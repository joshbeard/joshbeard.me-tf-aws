# ------------------------------------------------------------------------------
# joshbeard.me - CloudFront distribution
# ------------------------------------------------------------------------------
resource "aws_cloudfront_distribution" "joshbeard_distribution" {
  origin {
    domain_name = aws_s3_bucket.joshbeard_site.website_endpoint
    origin_id   = "S3Origin-${var.bucket_name}"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols     = [
          "TLSv1",
          "TLSv1.1",
          "TLSv1.2",
        ]
    }
  }

  # US, Canada, UK, Europe
  price_class         = "PriceClass_100"
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = ["www.${var.domain}",var.domain]

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.joshbeard_logs.bucket_domain_name
    prefix          = "joshbeard/"
  }

  default_cache_behavior {
    compress         = true
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin-${aws_s3_bucket.joshbeard_site.bucket}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.joshbeard_me.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}
