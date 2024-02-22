variable "server_port" {
  description = "Server use this port for grafana access."
  type = number
  default = 3000
}
variable "ssh_port" {
  description = "Describes the ssh port"
  type = number
  default = 22
}

variable "ami_id" {
  default = "ami-0c7217cdde317cfec"
  description = "This describes the ami id"
}

variable "instance_type" {
  default = "t2.micro"
  description = "Describes the instance type"
}