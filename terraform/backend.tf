terraform {
  backend "s3" {
    bucket         = "prestashop-tf-state-bucket"
    key            = "prestashop/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}