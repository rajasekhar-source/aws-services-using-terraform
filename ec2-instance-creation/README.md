# EC2 Instance creation
Create EC2 Instance using Terraform and provision a webserver with userdata.
## Step 1: In ec2-settings.tf - Creating terraform settings block
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
```

## Step 2: In ec2-resource.tf - Creating terraform resources blcok

- Create [EC2 Instance Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- Understand about [File Function](https://www.terraform.io/docs/language/functions/file.html)

```t
# Resource: EC2 Instance
resource "aws_instance" "testec2" {
  ami = "ami-04d29b6f966df1537"
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
```

## Step 3: Review file app1-install.sh
```sh
#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<h1>Welcome to first terraform - APP-1</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to terraform - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html
```

## Step 4: Access Application
- **Important Note:** verify if default VPC security group has a rule to allow port 80
```t
# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html

# Access metadata.html
http://<PUBLIC-IP>/app1/metadata.html
```
