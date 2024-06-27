variable "takeinput" {
    type = list 
    default = ["name","address","email"]

}

output "demofunc" {
    value = join("--->",var.takeinput)
}

# there are many functions, here i have used Join function, which takes a separator and a list