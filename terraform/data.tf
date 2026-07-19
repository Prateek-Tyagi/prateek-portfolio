data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Project   = "prateek-portfolio"
    ManagedBy = "terraform"
    Repo      = var.github_repo
  }

  www_domain          = "www.${var.domain_name}"
  redirect_www_domain = "www.${var.redirect_domain}"

  site_bucket_name = "${replace(var.domain_name, ".", "-")}-site"

  # Both hosted zones already exist in Route 53 — looked up, never created.
  primary_zone_id  = data.aws_route53_zone.primary.zone_id
  redirect_zone_id = data.aws_route53_zone.redirect.zone_id
}

# prateek.co.uk — existing public hosted zone (created manually).
data "aws_route53_zone" "primary" {
  name         = var.domain_name
  private_zone = false
}

# prateektyagi.com — existing public hosted zone.
data "aws_route53_zone" "redirect" {
  name         = var.redirect_domain
  private_zone = false
}
