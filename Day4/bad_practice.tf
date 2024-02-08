provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "example"{
    ami = "ami-01c647eace872fc02"
    instance_type = "t2.micro"
}
# This is bad practice as we are hard coding the ami and instance type . Rather then using directly we 
# can store the ami,instance type in a variable and then access it to create a resource . 