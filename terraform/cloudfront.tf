locals {
  primary_origin_id = "s3-${local.site_bucket_name}"
}

# AWS-managed cache policy tuned for static content.
data "aws_cloudfront_cache_policy" "optimized" {
  name = "Managed-CachingOptimized"
}

# ---- Origin Access Control (modern replacement for OAI) -------------------
resource "aws_cloudfront_origin_access_control" "site" {
  name                              = "${local.site_bucket_name}-oac"
  description                       = "OAC for ${var.domain_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# ---- Security response headers (HSTS etc.) --------------------------------
resource "aws_cloudfront_response_headers_policy" "security" {
  name = "${replace(var.domain_name, ".", "-")}-security-headers"

  security_headers_config {
    strict_transport_security {
      access_control_max_age_sec = 63072000
      include_subdomains         = true
      preload                    = true
      override                   = true
    }
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override     = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override        = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override   = true
    }
  }
}

# ---- CloudFront Functions -------------------------------------------------
resource "aws_cloudfront_function" "redirect_www" {
  name    = "${replace(var.domain_name, ".", "-")}-www-to-apex"
  runtime = "cloudfront-js-2.0"
  comment = "301 www.${var.domain_name} -> https://${var.domain_name}"
  publish = true
  code    = templatefile("${path.module}/functions/redirect-www.js.tftpl", { primary_domain = var.domain_name })
}

resource "aws_cloudfront_function" "redirect_all" {
  name    = "${replace(var.redirect_domain, ".", "-")}-to-primary"
  runtime = "cloudfront-js-2.0"
  comment = "301 ${var.redirect_domain} (+www) -> https://${var.domain_name}"
  publish = true
  code    = templatefile("${path.module}/functions/redirect-all.js.tftpl", { primary_domain = var.domain_name })
}

# ---- Primary distribution: serves the site --------------------------------
resource "aws_cloudfront_distribution" "primary" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "prateek-portfolio — ${var.domain_name}"
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  aliases             = [var.domain_name, local.www_domain]

  origin {
    origin_id                = local.primary_origin_id
    domain_name              = aws_s3_bucket.site.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id
  }

  default_cache_behavior {
    target_origin_id           = local.primary_origin_id
    viewer_protocol_policy     = "redirect-to-https"
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD"]
    compress                   = true
    cache_policy_id            = data.aws_cloudfront_cache_policy.optimized.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.security.id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.redirect_www.arn
    }
  }

  # Single-page site: serve index.html for unknown paths.
  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.primary.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

# ---- Redirect distribution: 301s prateektyagi.com (+www) to primary -------
# A CloudFront Function returns the 301 at viewer-request, so the origin is
# never contacted; it exists only because a distribution requires one.
resource "aws_cloudfront_distribution" "redirect" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = "prateek-portfolio — 301 ${var.redirect_domain} -> ${var.domain_name}"
  price_class     = "PriceClass_100"
  aliases         = [var.redirect_domain, local.redirect_www_domain]

  origin {
    origin_id   = "redirect-placeholder"
    domain_name = var.domain_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "redirect-placeholder"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    cache_policy_id        = data.aws_cloudfront_cache_policy.optimized.id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.redirect_all.arn
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.redirect.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
