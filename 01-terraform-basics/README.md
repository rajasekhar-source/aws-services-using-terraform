# Terraform Command Basics

## What is terraform?
- A tool to create and manage infrastructure using code. 
## Why Terraform?
- To create the same infrastructure again and again without manual work.
## Infrastructure as Code (IaC)
- Writing AWS infrastructure as code instead of creating services using AWS console.
## Terraform Architecture
- Terraform uses providers to talk to cloud and state to track resources.

## Step-01: Introduction
- Understand basic Terraform Commands
  - terraform init
  - terraform validate
  - terraform plan
  - terraform apply
  - terraform destroy   

## Step-02: Review code for EC2 Instance
- **Pre-checks:** 
    - Ensure you have **default-vpc** in that respective region
    - Ensure AMI you are provisioning exists in that region if not update AMI ID 
    - Should verify your AWS Credentials in your local machine
```t
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
  ami           = "ami-04d29b6f966df1537" # Amazon Linux in ap-south-1, update as per your region
  instance_type = "t3.micro"
}
```

## Step-03: Terraform Core Commands
```t
# Initialize Terraform
terraform init

# Terraform Validate
terraform validate

# Terraform Plan to Verify what it is going to create / update / destroy
terraform plan

# Terraform Apply to Create EC2 Instance
terraform apply 
```

## Step-04: Verify the EC2 Instance in AWS Management Console
- Go to AWS Management Console and search EC2 service
- Verify newly created EC2 instance

## Step-05: Destroy Infrastructure
```t
# Destroy EC2 Instance
terraform destroy

# Delete Terraform files 
rm -rf .terraform*
rm -rf terraform.tfstate*
```