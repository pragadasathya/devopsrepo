

# Aws resource creation 
resource "aws_instance" "Prod" {
  ami = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "sathya"
  }
}