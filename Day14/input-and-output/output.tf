output "newoutput" {
  value = "Hello, ${var.takeinput}"
}

# terraform plan -var "takeinput=Pratik" (this will overwrite the default value)