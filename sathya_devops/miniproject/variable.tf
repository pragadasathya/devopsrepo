variable "vpc" {

    default = "10.81.0.0/16"
  
}

variable "sn" {

    default = "10.81.1.0/24"
  
}

variable "ami" {

    default = "ami-05b10e08d247fb927" 
  
}

variable "inst_type" {

    default = "t2.micro"
  
}

variable "pri_ip" {

    default = ["10.81.1.11"]
  
}

variable "eli_pri_ip" {

    default = "10.81.1.11"
  
}