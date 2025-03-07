

# 1. create VPC

resource "aws_vpc" "test_vpc" {

    cidr_block = var.vpc

    tags = {
      
      Name = "test_vpc"
    }
  
}

# 2.create internet gateway

resource "aws_internet_gateway" "test_igw" {

    vpc_id = aws_vpc.test_vpc.id

    tags = {
      
      Name = "test_igw"
    }
  
}


#3.crate route table

resource "aws_route_table" "test_rt" {

    vpc_id = aws_vpc.test_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }

    tags = {
        
        Name = "test_rt"
    }
  
}


# 4.create subnet

resource "aws_subnet" "test_sn" {

    vpc_id = aws_vpc.test_vpc.id
    cidr_block = var.sn

    tags = {
      
        Name  = "test_sn"

    }
  
}

#5 . associate subnet with route table

resource "aws_route_table_association" "test_rta" {

    route_table_id = aws_route_table.test_rt.id
    subnet_id = aws_subnet.test_sn.id
  
}

#6. create security group all ports 22,443,80

resource "aws_security_group" "test_sg" {

    vpc_id = aws_vpc.test_vpc.id

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH from anywhere (adjust as needed)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTPS from anywhere
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allows all outbound traffic
  }

    tags = {

     Name  = "test_sg"
    
    }
  
}

#7. create a network interface with an ip in the subnet that was created in step4

resource "aws_network_interface" "test_nic" {
    subnet_id       = aws_subnet.test_sn.id
    private_ips     = var.pri_ip
    security_groups = [aws_security_group.test_sg.id]

    tags = {

     Name  = "test_nic"
    
    }
  
}


#8.assign an elastic ip to the network created in step7

resource "aws_eip" "test_eip" {

    network_interface         = aws_network_interface.test_nic.id
    associate_with_private_ip = var.eli_pri_ip

    tags = {

     Name  = "test"
    
    }
  
}

#9.create an ec2 instance --to launch application

resource "aws_instance" "test_ser" {
    ami = var.ami
    instance_type = var.inst_type
    user_data = "${file("sathya.sh")}"

    network_interface {
    network_interface_id = aws_network_interface.test_nic.id
    device_index         = 0
  }

    tags = {

     Name  = "test_ser"
    
    }
  
}

output "ec2_pub_ip" {

    value = aws_instance.test_ser.public_ip
  
}