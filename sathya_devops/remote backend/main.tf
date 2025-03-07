provider "aws" {
  region = "us-east-1"
}

# Aws resource creation 
resource "aws_instance" "Prod" {
  ami = "ami-053a45fff0a704a47"
  instance_type = "t2.micro"

  tags = {
    Name = "sathya"
  }
}