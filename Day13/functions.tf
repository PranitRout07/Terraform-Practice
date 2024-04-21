//syntax
locals {
    name = "pranit"
    skills = ["Python","AWS","Jenkins","Kubernetes"]
    message = "${locals.name} have skills like ${locals.skills}"
}