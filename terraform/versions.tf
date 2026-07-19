terraform {
  # Native S3 state locking (use_lockfile) requires Terraform >= 1.10.
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }

  # Remote state on S3 with native lockfile locking (no DynamoDB table).
  # Concrete bucket/key/region come from backend.hcl at init time:
  #   terraform init -backend-config=backend.hcl
  backend "s3" {
    encrypt      = true
    use_lockfile = true
  }
}
