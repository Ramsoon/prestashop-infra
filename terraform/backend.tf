terraform {
  backend "s3" {
    bucket         = "prestashop-terraform-state-bucket"
    key            = "prestashop/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}