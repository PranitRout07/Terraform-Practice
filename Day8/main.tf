provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_id = "ami-01c647eace872fc02" # replace this
  instance_type = "t2.micro"
}
