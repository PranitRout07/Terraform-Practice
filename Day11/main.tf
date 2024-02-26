resource "aws_instance" "server" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.instance.id ]
  availability_zone = var.availability_zone
  tags = {
    Name = "EC2-Server"
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


