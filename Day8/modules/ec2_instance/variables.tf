variable "instance_type" {
  description = "This describes the instance type"
  type = string
#   default = "t2.micro"
}

variable "ami_id" {
    description = "This describes the ami image"
    type = string
    # default = "ami-01c647eace872fc02"
}

variable "subnet_id" {
    description = "This describes the subnet in which EC2 instance is running"
    type = string
}
variable "security_group_id" {
    description = "This describes security group the EC2 instance is using"
    type = string
}