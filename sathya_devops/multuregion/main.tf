provider "aws" {

    region = "us-east-1"
    alias = "sathya"
  
}

provider "aws" {

    region = "ap-south-1"
    alias = "gopi"
  
}

resource "aws_instance" "prod1" {
    ami = "ami-053a45fff0a704a47"
    instance_type = "t2.micro"


    provider = aws.sathya

    tags = {

        name = "test_prod"
    }
  
}

resource "aws_instance" "prod1" {
    ami = "ami-0ddfba243cbee3768"
    instance_type = "t2.micro"

    provider = aws.gopi

    tags = {
        name = "test_prod_1"
    }
  
}