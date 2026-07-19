provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "prateek-portfolio"
      ManagedBy = "terraform"
    }
  }
}

# CloudFront viewer certificates (ACM) MUST live in us-east-1, regardless of
# where the rest of the stack runs.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = {
      Project   = "prateek-portfolio"
      ManagedBy = "terraform"
    }
  }
}
