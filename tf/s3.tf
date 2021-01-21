# ------------------------------------------------------------------------------
# joshbeard.me - S3 website bucket
# ------------------------------------------------------------------------------
resource "aws_s3_bucket" "joshbeard_site" {
  bucket = var.bucket_name
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://${var.domain}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = aws_s3_bucket.joshbeard_logs.bucket
    target_prefix = "joshbeard"
  }

  tags = {
    "Name" = var.bucket_name
  }
}

# Log bucket
resource "aws_s3_bucket" "joshbeard_logs" {
  bucket        = "joshbeard-logs"
  acl           = "log-delivery-write"
  force_destroy = true
}

data "aws_iam_policy_document" "joshbeard_policies" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.joshbeard_site.bucket}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "joshbeard_policy" {
  bucket = aws_s3_bucket.joshbeard_site.id
  policy = data.aws_iam_policy_document.joshbeard_policies.json
}

output "website_endpoint" {
    value = aws_s3_bucket.joshbeard_site.website_endpoint
}
