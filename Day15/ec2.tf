resource "aws_instance" "web" {
    ami = "ami-0a0e5d9c7acc336f1" 
    instance_type = "t2.micro"
    key_name = aws_key_pair.new-key.key_name
    vpc_security_group_ids = [ aws_security_group.new-sg.id ]
}