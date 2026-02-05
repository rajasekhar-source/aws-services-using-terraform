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

# Resource Block
resource "aws_instance" "testec2" {
  ami           = "ami-0ff5003538b60d5ec" # Amazon Linux in ap-south-1, update as per your region
  instance_type = "t3.micro"
  tags = {
    "Name" = "EC2 Demo"
  }
}
