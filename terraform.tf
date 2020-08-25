terraform {
  backend "s3" {
    encrypt = true
    bucket  = "dev-terraform-backend"
    region  = "eu-west-3"
    key     = "dev/dev.tfstate"
  }
}
