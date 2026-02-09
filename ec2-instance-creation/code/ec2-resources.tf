# Resource Block
resource "aws_instance" "testec2" {
  ami           = "ami-04d29b6f966df1537" # Amazon Linux in ap-south-1, update as per your region
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}