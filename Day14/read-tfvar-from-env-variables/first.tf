variable "username" {
  
}

output "username" {
  value = var.username
}

//first create a environment variable using exact syntax :- export TF_VAR_username=cyrus (TF_VAR is must and the next part is the variable)

//then run terraform plan