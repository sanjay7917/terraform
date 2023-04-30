#Store our .tfstate file on Remote Location Like AWS-S3
terraform {
  backend "s3" {
    bucket = "godtierapp123123"
    region = "us-east-2"
    key    = "terraform.tfstate"
  }
}