terraform {
  required_providers {
    aws = {
      version = ">= 1.1.0"
    }
  }
}
provider "aws" {
  region     = "ap-south-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}
terraform {
  backend "s3" {
    bucket         = "san-demo-s3-us-east-1-tfbackend"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstateforgithubactions"
    profile        = "github-profile"
  }
}
