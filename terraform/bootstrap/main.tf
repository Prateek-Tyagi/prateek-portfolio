# One-time bootstrap: creates the S3 bucket that holds the main stack's remote
# state. Uses LOCAL state (chicken-and-egg), so this runs once and rarely again.
# Native S3 lockfile locking means no DynamoDB table is required.
#
#   cd terraform/bootstrap
#   terraform init
#   terraform apply
#
# Then run the main stack in ../ with: terraform init -backend-config=backend.hcl

terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "state_bucket_name" {
  description = "Globally-unique S3 bucket name for remote state. Set in bootstrap/terraform.tfvars (gitignored) or pass with -var. Convention: prateek-portfolio-tfstate-<ACCOUNT_ID>."
  type        = string
}

resource "aws_s3_bucket" "state" {
  bucket = var.state_bucket_name

  tags = {
    Project   = "prateek-portfolio"
    ManagedBy = "terraform"
    Purpose   = "terraform-remote-state"
  }
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "state_bucket" {
  value = aws_s3_bucket.state.bucket
}
