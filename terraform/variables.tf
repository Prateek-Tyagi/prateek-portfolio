variable "domain_name" {
  description = "Primary domain that serves the site over HTTPS (apex). e.g. prateek.co.uk"
  type        = string
}

variable "redirect_domain" {
  description = "Secondary domain that 301-redirects to the primary (apex + www). e.g. prateektyagi.com"
  type        = string
}

variable "aws_region" {
  description = "Primary AWS region for the S3 bucket and account-level resources."
  type        = string
  default     = "eu-west-2"
}

variable "github_repo" {
  description = "GitHub repo (owner/name) whose main branch may assume the deploy role via OIDC."
  type        = string
  default     = "Prateek-Tyagi/prateek-portfolio"
}

variable "github_branch" {
  description = "Branch whose workflow runs may assume the deploy role."
  type        = string
  default     = "main"
}

variable "create_oidc_provider" {
  description = "Create the GitHub Actions OIDC provider. Keep false to REUSE an existing token.actions.githubusercontent.com provider (the common case). Set true only if the account has none. Check with: aws iam list-open-id-connect-providers"
  type        = bool
  default     = false
}

variable "budget_email" {
  description = "Email address that receives the monthly AWS budget alert."
  type        = string
}

variable "budget_limit_usd" {
  description = "Monthly cost budget in USD (billing tripwire)."
  type        = number
  default     = 5
}
