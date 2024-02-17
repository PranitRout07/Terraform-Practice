# provider "aws" {
#     region = "us-east-1"
# }
# resource "aws_sns_topic" "demo-topic" {
#   name = "demo-topic"
# }
# resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
#   topic_arn = aws_sns_topic.demo-topic.id
#   protocol  = "email"
#   endpoint  = "pranitrout72@gmail.com"
#   endpoint_auto_confirms = true
# }