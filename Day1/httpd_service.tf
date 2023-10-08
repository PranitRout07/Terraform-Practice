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
                sudo yum update -y
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "Terraform is easy!!!" > /var/www/html/index.html
                EOF
  user_data_replace_on_change = true 
}
resource "aws_security_group" "instance" {

    name = "terraform-SG"
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}