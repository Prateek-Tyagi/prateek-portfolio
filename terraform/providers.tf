provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

# CloudFront viewer certificates (ACM) MUST be created in us-east-1, regardless
# of where the rest of the stack lives. This aliased provider is used ONLY for
# the ACM certificates.
provider "aws" {
  alias  = "use1"
  region = "us-east-1"

  default_tags {
    tags = local.common_tags
  }
}
