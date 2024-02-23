provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "example" {
  ami = "ami-01c647eace872fc02"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.instance.id ]
  tags = {
    Name = "terraform-example"
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo yum install stress -y
                sudo stress --cpu 4 --timeout 300s
                EOF
  user_data_replace_on_change = true 
}
resource "aws_security_group" "instance" {

    name = "terraform-SG"
    ingress  {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}
variable "server_port" {
  description = "Server use this port for http requests"
  type = number
  default = 80
}

variable "ssh_port" {
  description = "Describes the ssh port"
  type = number
  default = 22
}
