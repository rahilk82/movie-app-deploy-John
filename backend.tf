terraform {
  backend "s3" {
    bucket         = "rahil-account-terraform-state"
    key            = "Test/terraform.tfstate"
    dynamodb_table = "rahil-account-tfstate-lock"
    region         = "eu-west-1"
  }
}