provider "github" {
  owner = var.username
  token = var.token
}

resource "github_repository" "repo-name" {
  name        = "repo_created_through_terraform"
  description = "This is a github repository created using terraform"
  visibility  = "private"
  auto_init   = true

}


//use terraform apply --auto-approve command to directly apply changes without giving any yes or no answer
//in tfstate file all the details and state is maintained (very important file)



# Suppose you have created two repositories and you want to delete on of the repository,
# Then you have to use this command : 
# terraform destroy --target github_resource.repo_name (it is like <resouce_name>.<name_of_the resource_locally>)


//terraform refresh :- this command is in such a situation:
//Suppose you have created a repository with a description using terraform . Now you have 
//changed the description of the repo manually . No the state is changed . To make the state in sync 
//you have to use terraform refresh , this will refresh the state 


//terraform output <output_var_name>
//this will print the output in the terminal 


//terraform console
//after running this command it will open a terminal
//in this terminal we can see the details or any output . 
//for e.g.  var.username, github_repository.repo-name.html_url , github_repository.repo-name.full_name and many more . 


//terraform fmt
// this command used to indent all the terraform file code within a directory 