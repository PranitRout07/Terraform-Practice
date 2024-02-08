provider "aws" {
    region = "us-east-1"
}
variable "instance_type" {
  description = "This describes the instance type"
  type = string
  default = "t2.micro"
}
variable "ami_id" {
    description = "This describes the ami image"
    type = string
    default = "ami-01c647eace872fc02"
}

resource "aws_instance" "example"{
    ami = var.ami_id
    instance_type = var.instance_type
}

#here input variable is used . 