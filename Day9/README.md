# Automated Steps Using Terraform:

1. I started by creating an IAM role for Lambda, granting permissions including CloudWatchFullAccess, AmazonSNSFullAccess, AmazonEC2FullAccess, CloudWatchLogsFullAccess, and CloudWatchEventsBuiltInTargetExecutionAccess using Terraform.
2. Next, I proceeded to define the SNS topic resource and set up a subscription using Terraform. This ensured that notifications would be sent to my email address.
3. Following that, I wrote the Python code for the Lambda function. Then, I utilized Terraform to deploy the Lambda function, ensuring it had the necessary permissions by attaching the IAM role created earlier.
4.Subsequently, I configured the CloudWatch event trigger using Terraform, ensuring that the Lambda function would be executed based on changes in EC2 instance states. In this step, I made sure to include the "aws_lambda_permission" resource to grant the necessary permissions.
5.Finally executed all these terraform code using the following commands :
terraform init
terraform plan
terraform apply
6. To check my code is working or not i have created EC2 instance and verified that if i am getting notification on my email correctly on the basis of EC2 instance state .

# Manual Task:

The only manual task remaining in the automated process is subscribing to the SNS topic using my email address for notifications.

# Problems Faced:

While implementing automation with Terraform for managing EC2 instance lifecycles, I encountered minor hurdles. One notable challenge was 
forgetting to include the "aws_lambda_permission" resource while setting up the CloudWatch event trigger.
