terraform {
  backend "s3" {
    bucket = "sathya-s3-bucket"
    key    = "sathya/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}