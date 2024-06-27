variable "userdetails" {
    type = map 
    default = {
        pranit = 22 
        gaurav = 27 
    } 
}

variable "username" {
    type = string
}

output "userdetails" {
  value = "My name is ${var.username} and my age is : ${lookup(var.userdetails,var.username)}"
}

//takes input username and shows the age.