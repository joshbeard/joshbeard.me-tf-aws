# Deployment of AWS resources for joshbeard.me
module "joshbeard_me_aws" {
    source = "github.com/joshbeard/tf-aws-site.git"
    domain = "joshbeard.me"
    log_bucket_name = "joshbeard-logs"
}

module "joshbeard_me_migadu" {
    source = "github.com/joshbeard/tf-migadu-route53.git"

    domain        = "joshbeard.me"
    zone_id       = module.joshbeard_me_aws.zone_id
    dkim          = "v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwLut0Bap/mh3HE2rDPchHVrEcaKAfE1X5/k+7fBiIdRgk8GFoMiG3WpbaWygLS0Hw03ZjdeiIPQW/bfB7tz88NIwhIlq4VI2w+oBjF9pciLgzu0gFRGEC1KdRjn7M3YD/KTURS9kAAkgLKFWXqrUsuhuM00mZQn72MA/N9DSPfwIDAQAB"
    migadu_verify = "d1wmwhle"
    txt_records   = [
        "google-site-verification=RViz888k76klP5cJLLhWObOAMoYIF8vXMtXh52iMdNY",
        "keybase-site-verification=DCBFW1VwtOcrdnGbDKrcsthPHZtSCth1mWx0oUE-SS4"
    ]
}