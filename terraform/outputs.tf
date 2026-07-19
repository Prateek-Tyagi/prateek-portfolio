# ---- These four map 1:1 to the GitHub Actions secrets in deploy.yml -------
output "aws_role_arn" {
  description = "GitHub secret AWS_ROLE_ARN — the OIDC deploy role."
  value       = aws_iam_role.github_deploy.arn
}

output "aws_region" {
  description = "GitHub secret AWS_REGION."
  value       = var.aws_region
}

output "s3_bucket" {
  description = "GitHub secret S3_BUCKET — the site origin bucket."
  value       = aws_s3_bucket.site.bucket
}

output "cloudfront_distribution_id" {
  description = "GitHub secret CLOUDFRONT_DISTRIBUTION_ID — the primary distribution."
  value       = aws_cloudfront_distribution.primary.id
}

# ---- Helpful extras --------------------------------------------------------
output "primary_cloudfront_domain" {
  description = "Primary distribution domain (test before DNS propagates)."
  value       = aws_cloudfront_distribution.primary.domain_name
}

output "redirect_cloudfront_domain" {
  description = "Redirect distribution domain."
  value       = aws_cloudfront_distribution.redirect.domain_name
}

output "oidc_provider_mode" {
  description = "Whether Terraform created the GitHub OIDC provider or reused an existing one."
  value       = var.create_oidc_provider ? "created" : "reused-existing"
}
