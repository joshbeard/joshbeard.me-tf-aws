# joshbeard.me

This is a Terraform codebase for deploying AWS resources for the
[joshbeard.me](https://joshbeard.me) website.

* Uses the [tf-aws-site](https://github.com/joshbeard/tf-aws-site) module for
  deploying the common resources for this website (S3, CloudFront, ACM, IAM, Route53)
* Uses the [tf-migadu-route53](https://github.com/joshbeard/tf-migadu-route53)
  module for managing DNS records for mail in Route53.
* Uses my [tf-remote-state](https://gitlab.com/joshbeard/tf-remote-state).

The [`Makefile`](Makefile) is included for local use for running Terraform in Docker.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_joshbeard_me_aws"></a> [joshbeard\_me\_aws](#module\_joshbeard\_me\_aws) | github.com/joshbeard/tf-aws-site.git | n/a |
| <a name="module_joshbeard_me_migadu"></a> [joshbeard\_me\_migadu](#module\_joshbeard\_me\_migadu) | github.com/joshbeard/tf-migadu-route53.git | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.resume_update](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.resume_update](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.resume_update](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_policy_document.resume_update](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
