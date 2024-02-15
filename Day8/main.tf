provider "aws" {
  region = "us-east-1"
}
module "vpc" {
  source = "./modules/vpc"
}
module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_id = "ami-01c647eace872fc02" # replace this
  instance_type = "t2.micro"
  subnet_id = module.vpc.subnet_id
  security_group_id = module.vpc.security_group_id
}
