# Terraform Configuration Syntax

## Step1: Terraform Language Fundamentals
Before creating infrastructure, understand the basic building blocks of Terraform.
- What you should know
  - Terraform uses ```blocks``` to define configurations
  - Each block contains ```arguments``` as key-value pairs
  - ```Identifiers``` are logical names used to reference resources
  - ```Comments``` help explain code and improve readability
 


## Step2: Terraform Configuration Syntax
Terraform follows a structured and declarative syntax.
### Terraform follows a structured and declarative syntax.
```t
<BLOCK_TYPE> "<LABEL_1>" "<LABEL_2>" {
  <ARGUMENT_NAME> = <VALUE>
}
```
### Example: AWS EC2 Resource
```t
resource "aws_instance" "ec2_demo" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = "t3.micro"
}
```

## Step3: Understand about Arguments, Attributes and Meta-Arguments.
  - ```resource``` → Type of block
  - ```aws_instance``` → AWS resource type
  - ```ec2_demo``` → Resource identifier
  - ```ami```, ```instance_type``` → Arguments

## Step-04: Understanding Blocks
- Blocks are the main structure in Terraform
  - ```terraform``` → Terraform settings and provider versions
  - ```provider``` → Cloud provider configuration
  - ```resource``` → Infrastructure components
  - ```variable``` → Input values
  - ```output``` → Display values after apply
  - ```locals``` → Reusable expressions
  - ```data``` → Read existing resources
  - ```module```→ Reusable Terraform code

  Each block has a specific purpose and follows the same syntax style.
