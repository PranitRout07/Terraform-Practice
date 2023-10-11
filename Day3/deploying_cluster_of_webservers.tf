provider "aws" {
    region = "us-east-1"
}

resource "aws_launch_configuration" "example" {
  image_id = "ami-01c647eace872fc02"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.instance.id ]

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "Launching a cluster of webservers using terraform!!!" > /var/www/html/index.html
                EOF
  lifecycle {
    create_before_destroy = true
  }
 
}


resource "aws_autoscaling_group" "example" {
    launch_configuration = aws_launch_configuration.example.name
    vpc_zone_identifier = data.aws_subnets.default.ids

    target_group_arns = [aws_lb_target_group.asg.arn]
    health_check_type = "ELB"
    min_size = 2
    max_size = 10
    tag {
      key = "Name"
      value = "terraform-asg-example"
      propagate_at_launch = true
    }
}




data "aws_vpc" "default"{
  default = true                //to search for default vpc
}
data "aws_subnets" "default"{
  filter {
    name = "vpc-id"                     //to search for the subnets in the default vpc
    values = [data.aws_vpc.default.id]
  }
}


resource "aws_security_group" "instance" {

    name = "terraform-SG"
    ingress  {
        from_port = var.server_port
        to_port = var.server_port
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

variable "server_port" {
  description = "Port number through which server receives http requests"
  type = number
  default = 80
}


resource "aws_lb" "example" {
  name = "terraform-asg-example"
  load_balancer_type = "application"
  subnets = data.aws_subnets.default.ids
  security_groups = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port = 80
  protocol = "HTTP"
  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
  }
 }
}
resource "aws_security_group" "alb" {

    name = "terraform-example-alb"
    ingress  {
        from_port = var.server_port
        to_port = var.server_port
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

resource "aws_lb_target_group" "asg" {
    name = "terraform-asg-example"
    port = var.server_port
    protocol = "HTTP"
    vpc_id = data.aws_vpc.default.id
    health_check {
        path = "/"
        protocol = "HTTP"
        matcher = "200"
        interval = 15
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
}
resource "aws_lb_listener_rule" "asg" {
    listener_arn = aws_lb_listener.http.arn
    priority = 100
    condition {
        path_pattern {
            values = ["*"]
        }
    }
    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.asg.arn
    }
}

output "alb_dns_name" {
 value = aws_lb.example.dns_name
 description = "The domain name to access load balancer"
}
