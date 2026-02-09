# Terraform Variables

## Step 1: Introduction
### Terraform Concepts
- Terraform Input Variables
- Terraform Output Values

### What are we going to learn ?
1. Learn about Terraform `Input Variable` basics
  - AWS Region
  - Instance Type
2. Define `Security Groups` and Associate them as a `List item` to AWS EC2 Instance  
  - vpc-ssh
  - vpc-web
3. Learn about Terraform `Output Values`
  - Public IP
  - Public DNS

## Step 2: ec2-variables.tf - Define Input Variables in Terraform
- [Terraform Input Variables](https://www.terraform.io/docs/language/values/variables.html)
- [Terraform Input Variable Usage - 10 different types](https://github.com/stacksimplify/hashicorp-certified-terraform-associate/tree/main/05-Terraform-Variables/05-01-Terraform-Input-Variables)
```t
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"  
}
```
- Reference the variables in respective `.tf`fies
```t
# ec2-versions.tf
region  = var.aws_region

# ec2-myinstance.tf
instance_type = var.instance_type
```

## Step 3: ec2-mysecuritygroups.tf - Define Security Group Resources in Terraform
- [Resource: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
```t
# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Dev VPC web"
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
- Reference the security groups in `ec2-myinstance.tf` file as a list item
```t
# List Item
vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]  
```

- Reference the datasource in `ec2-myinstance.tf` file
```t
# Reference Datasource to get the latest AMI ID
ami = data.aws_ami.amzlinux2.id 
```

## Step 4: ec2-myinstance.tf - Define EC2 Instance Resource
- [Resource: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
```t
# EC2 Instance
resource "aws_instance" "testec2" {
  ami = data.aws_ami.amzlinux2.id 
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]  
  tags = {
    "Name" = "EC2 Demo 2"
  }
}
```


## Step 5: ec2-outputs.tf - Define Output Values 
- [Output Values](https://www.terraform.io/docs/language/values/outputs.html)
```t
# Terraform Output Values
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.testec2.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.testec2.public_dns
}
```


## Step 6: Access Application
```t
# Access index.html
http://<PUBLIC-IP>/index.html
http://<PUBLIC-IP>/app1/index.html
```

## Step 7: Clean-Up
```t
# Terraform Destroy
terraform plan -destroy  # You can view destroy plan using this command
terraform destroy

# Clean-Up Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```
