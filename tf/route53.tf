# ------------------------------------------------------------------------------
# joshbeard.me - route53 DNS
# ------------------------------------------------------------------------------
resource "aws_route53_zone" "joshbeard_me" {
  name = var.domain
}

# ACM validation
resource "aws_route53_record" "joshbeard_me_acm_validate" {
  for_each = {
    for dvo in aws_acm_certificate.joshbeard_me.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.joshbeard_me.zone_id
}

resource "aws_route53_record" "joshbeard-root-a" {
  provider                = aws.cert
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.joshbeard_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.joshbeard_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "joshbeard-www-a" {
  provider                = aws.cert
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = "www.${var.domain}" #var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.joshbeard_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.joshbeard_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "joshbeard-status-cname" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = "status.${var.domain}"
  type    = "CNAME"
  ttl     = 1800
  records = ["stats.uptimerobot.com"]
}
