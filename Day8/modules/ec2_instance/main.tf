resource "aws_instance" "example"{
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]

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

