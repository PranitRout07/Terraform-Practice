resource "aws_security_group" "new-sg" {

    //dynamic block to avoid repeating the ingress
    name = "new-sg"
    dynamic "ingress" {
        for_each = [ 22,80 ]
            iterator = port

        content {
            from_port = port.value
            to_port = port.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
      
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}