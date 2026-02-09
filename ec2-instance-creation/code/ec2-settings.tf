# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 6.30" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  region  = "ap-south-1"
}
