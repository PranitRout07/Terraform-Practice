resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch=true  //this automatically assigns public IP . 
  tags = {
    Name = "Public-Subnet"
  }
}