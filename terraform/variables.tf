variable "aws_region" {
  description = "Primary AWS region for the S3 site bucket and account-level resources."
  type        = string
  default     = "ap-south-1"
}

variable "domain_name" {
  description = "Apex domain the site is served from, e.g. prateek.dev. A public Route 53 hosted zone for this domain must already exist in the account."
  type        = string
}

variable "include_www" {
  description = "Also serve and redirect www.<domain_name>."
  type        = bool
  default     = true
}

variable "site_bucket_name" {
  description = "Override the S3 bucket name for the site. Leave null to derive it from the domain (dots replaced with dashes, '-site' suffix)."
  type        = string
  default     = null
}

variable "cloudfront_price_class" {
  description = "CloudFront price class. PriceClass_100 is cheapest (NA + EU edge locations)."
  type        = string
  default     = "PriceClass_100"

  validation {
    condition     = contains(["PriceClass_100", "PriceClass_200", "PriceClass_All"], var.cloudfront_price_class)
    error_message = "cloudfront_price_class must be one of PriceClass_100, PriceClass_200, PriceClass_All."
  }
}

# ---- GitHub Actions OIDC ----

variable "github_owner" {
  description = "GitHub org/user that owns the repo allowed to assume the deploy role."
  type        = string
  default     = "Prateek-Tyagi"
}

variable "github_repo" {
  description = "GitHub repository name allowed to assume the deploy role."
  type        = string
  default     = "prateek-portfolio"
}

variable "github_branch" {
  description = "Branch whose workflow runs are allowed to assume the deploy role."
  type        = string
  default     = "main"
}

variable "create_oidc_provider" {
  description = "Create the GitHub Actions OIDC provider. Set to false if token.actions.githubusercontent.com already exists in this account."
  type        = bool
  default     = true
}

# ---- Billing guardrail ----

variable "budget_limit_usd" {
  description = "Monthly cost budget in USD. You get alerted well before this."
  type        = number
  default     = 5
}

variable "budget_notification_email" {
  description = "Email address that receives budget threshold alerts."
  type        = string
  default     = "parteekrajvats@gmail.com"
}
