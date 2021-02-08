resource "aws_iam_user" "s3-deployer" {
  name = "s3-deploy-joshbeard.me"
  path = "/"

  tags = {
    "bucket" = var.bucket_name
  }
}

resource "aws_iam_access_key" "s3-deployer" {
  user = aws_iam_user.s3-deployer.name
}

resource "aws_iam_policy" "s3-deployer" {
  name = "s3-deploy-joshbeard.me"
  description = "Policy to deploy joshbeard.me s3 website"
  provider = aws
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3DeployPolicy",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectVersionAcl",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::s3-website-joshbeard-me",
                "arn:aws:s3:::s3-website-joshbeard-me/*"
            ]
        }
    ]
}
EOF
}
resource "aws_iam_user_policy_attachment" "s3-deployer" {
  user       = aws_iam_user.s3-deployer.name
  policy_arn = aws_iam_policy.s3-deployer.arn
}