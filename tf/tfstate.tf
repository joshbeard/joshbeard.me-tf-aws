terraform {
  backend "s3" {
    bucket  = "tf-remote-state20201021064517629300000002"
    key     = "joshbeard.me/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
    kms_key_id = "04dc01e6-bd7b-4873-8468-68ba0217a4e2"
  }
}
