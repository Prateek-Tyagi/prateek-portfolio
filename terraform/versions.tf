terraform {
  # Native S3 state locking (use_lockfile) requires Terraform >= 1.10.
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }

  # Remote state on S3 with native lockfile locking (no DynamoDB table needed).
  # Concrete values are supplied at init time from backend.hcl so this file
  # stays free of account-specific details:
  #   terraform init -backend-config=backend.hcl
  backend "s3" {
    key          = "portfolio/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
