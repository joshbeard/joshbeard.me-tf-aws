# ------------------------------------------------------------------------------
# joshbeard.me
# Certificates
# ------------------------------------------------------------------------------
resource "aws_acm_certificate" "joshbeard_me" {
  provider          = aws.cert
  domain_name       = "joshbeard.me"
  validation_method = "DNS"
  subject_alternative_names = ["*.joshbeard.me"]

  lifecycle {
    create_before_destroy = true
  }

  options {
      certificate_transparency_logging_preference = "ENABLED"
  }

  tags = {
    "Name" = "joshbeard.me"
  }
}

resource "aws_acm_certificate_validation" "joshbeard_me" {
  provider                = aws.cert
  certificate_arn         = aws_acm_certificate.joshbeard_me.arn
  validation_record_fqdns = [for record in aws_route53_record.joshbeard_me_acm_validate : record.fqdn]
}
