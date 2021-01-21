# ------------------------------------------------------------------------------
# joshbeard.me - route53 (dns) records for mail
# ------------------------------------------------------------------------------

#
# ==== MX
#
resource "aws_route53_record" "joshbeard-mx" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = var.domain
  type    = "MX"
  ttl     = 3600
  records = ["10 aspmx1.migadu.com","20 aspmx2.migadu.com"]
}

#
# ==== TXT (spf, verification)
#
resource "aws_route53_record" "joshbeard-txt" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = 300
  records = [
      "hosted-email-verify=d1wmwhle",
      "v=spf1 include:spf.migadu.com -all",
      "keybase-site-verification=DCBFW1VwtOcrdnGbDKrcsthPHZtSCth1mWx0oUE-SS4"
  ]
}

#
# ==== DMARC
#
resource "aws_route53_record" "joshbeard-dmarc" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = "_dmarc.${var.domain}"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject"]
}

#
# ==== DKIM
#
resource "aws_route53_record" "joshbeard_dkim" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = "default._domainkey.joshbeard.me"
  records = ["v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwLut0Bap/mh3HE2rDPchHVrEcaKAfE1X5/k+7fBiIdRgk8GFoMiG3WpbaWygLS0Hw03ZjdeiIPQW/bfB7tz88NIwhIlq4VI2w+oBjF9pciLgzu0gFRGEC1KdRjn7M3YD/KTURS9kAAkgLKFWXqrUsuhuM00mZQn72MA/N9DSPfwIDAQAB"]
  type    = "TXT"
  ttl     = 1800
}
resource "aws_route53_record" "joshbeard-dkim-1" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = "key1._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = 3600
  records = ["key1.joshbeard.me._domainkey.migadu.com"]
}
resource "aws_route53_record" "joshbeard-dkim-2" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = "key2._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = 3600
  records = ["key2.joshbeard.me._domainkey.migadu.com"]
}
resource "aws_route53_record" "joshbeard-dkim-3" {
  zone_id = aws_route53_zone.joshbeard_me.zone_id
  name    = "key3._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = 3600
  records = ["key3.joshbeard.me._domainkey.migadu.com"]
}
