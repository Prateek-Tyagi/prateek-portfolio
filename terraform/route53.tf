# ---- Primary domain -> primary distribution ------------------------------
resource "aws_route53_record" "primary_a" {
  zone_id = local.primary_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.primary.domain_name
    zone_id                = aws_cloudfront_distribution.primary.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "primary_aaaa" {
  zone_id = local.primary_zone_id
  name    = var.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.primary.domain_name
    zone_id                = aws_cloudfront_distribution.primary.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "primary_www_a" {
  zone_id = local.primary_zone_id
  name    = local.www_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.primary.domain_name
    zone_id                = aws_cloudfront_distribution.primary.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "primary_www_aaaa" {
  zone_id = local.primary_zone_id
  name    = local.www_domain
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.primary.domain_name
    zone_id                = aws_cloudfront_distribution.primary.hosted_zone_id
    evaluate_target_health = false
  }
}

# ---- Redirect domain -> redirect distribution -----------------------------
resource "aws_route53_record" "redirect_a" {
  zone_id = local.redirect_zone_id
  name    = var.redirect_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.redirect.domain_name
    zone_id                = aws_cloudfront_distribution.redirect.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "redirect_aaaa" {
  zone_id = local.redirect_zone_id
  name    = var.redirect_domain
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.redirect.domain_name
    zone_id                = aws_cloudfront_distribution.redirect.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "redirect_www_a" {
  zone_id = local.redirect_zone_id
  name    = local.redirect_www_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.redirect.domain_name
    zone_id                = aws_cloudfront_distribution.redirect.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "redirect_www_aaaa" {
  zone_id = local.redirect_zone_id
  name    = local.redirect_www_domain
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.redirect.domain_name
    zone_id                = aws_cloudfront_distribution.redirect.hosted_zone_id
    evaluate_target_health = false
  }
}
