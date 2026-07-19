output "site_bucket_name" {
  description = "S3 bucket that holds the static site. Set as the S3_BUCKET repo variable."
  value       = aws_s3_bucket.site.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID. Set as the CLOUDFRONT_DISTRIBUTION_ID repo variable."
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain (useful for testing before DNS propagates)."
  value       = aws_cloudfront_distribution.site.domain_name
}

output "github_actions_role_arn" {
  description = "IAM role ARN for GitHub Actions. Set as the AWS_ROLE_ARN repo secret/variable."
  value       = aws_iam_role.github_deploy.arn
}

output "hosted_zone_name_servers" {
  description = "Route 53 name servers — point your registrar here if the domain is registered elsewhere."
  value       = data.aws_route53_zone.site.name_servers
}

output "acm_certificate_arn" {
  description = "Validated ACM certificate ARN used by CloudFront."
  value       = aws_acm_certificate_validation.site.certificate_arn
}
