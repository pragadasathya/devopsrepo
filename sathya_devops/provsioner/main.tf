


resource "aws_vpc" "test_vpc" {

    cidr_block = var.vpc

    tags = {
      
      Name = "test_vpc"
    }
  
}



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
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {

     Name  = "test_sg"
    
    }
  
}

resource "aws_instance" "jenkins_ser" {

    ami = "ami-053a45fff0a704a47"
    instance_type = "t2.micro"
    key_name = "jenkinskey"
    vpc_security_group_ids = [aws_security_group.test_sg.id]
    subnet_id = aws_subnet.test_sn.id

    connection {
      
      type = "ssh"
      user = "ec2-user@ec2-52-87-204-72.compute-1.amazonaws.com"
      private_key = file("C:/Users/Vamsi Sridhar/Downloads/jenkinskey.ppk")
      host = self.public_ip
    }

    provisioner "local-exec" {

        command = "echo 'HI this is sathya devops' > sathya.txt "       
    }

    provisioner "remote-exec" {
    inline = [
      "sudo yum update –y",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",

     "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",

     "sudo yum upgrade",
     "sudo dnf install java-17-amazon-corretto -y",
     "sudo yum install jenkins -y",
     "sudo systemctl enable jenkins",
     "sudo systemctl start jenkins",
     "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]

  }

    tags = {
        Name = "jenkins"
    }

}

output "name" {
    value = aws_instance.jenkins_ser.public_ip
  
}
  
