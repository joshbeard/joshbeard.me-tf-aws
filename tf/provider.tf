provider "aws" {
  region  = "us-west-2"
}

# Certificates use the 'us-east-1' region.
provider "aws" {
  region  = "us-east-1"
  alias   = "cert"
}
