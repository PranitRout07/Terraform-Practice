provider "aws" {
  region = "us-east-1"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "ec2" {
  source = "./modules/ec2"
}


module "grafana" {
  source = "./modules/grafana"
  ami_id = "ami-0c7217cdde317cfec" 
  instance_type = "t2.micro"
}

output "access_key_id" {
  value = module.cloudwatch.access_key_id
  sensitive = true
}

output "secret_access_key" {
  value = module.cloudwatch.secret_access_key
  sensitive = true
}

output "public_ip" {
  value = module.grafana.grafana_public_ip
  description = "The public IP address of the web server"
}