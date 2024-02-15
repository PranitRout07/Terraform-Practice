resource "aws_instance" "example"{
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = module.aws_subnet.main.id
    vpc_security_group_ids = [aws_security_group.securi]
}

