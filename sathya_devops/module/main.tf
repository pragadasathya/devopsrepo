
module "aws_instance" {

    source = "./s3_buck_module"
    ami = "ami-053a45fff0a704a47"
    instance_type= "t2.micro" 
  
}