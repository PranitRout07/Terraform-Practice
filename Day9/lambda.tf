provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "ec2_state_check.py"
  output_path = "ec2_state_check.zip"
}



resource "aws_lambda_function" "lambda" {
  function_name = "ec2_state_check"

  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"

  role    = aws_iam_role.lambda_role_terraform.arn
  handler = "ec2_state_check.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.demo-topic.id
    }
  }
}


resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name                = "ec2_state_change_trigger"
  event_pattern = jsonencode({
 
                
            "source": [
                "aws.ec2"
            ],
            "detail-type": [
                "EC2 Instance State-change Notification"
            ],
            "detail": {
                "state": [
                "pending",
                "running",
                "shutting-down",
                "stopped",
                "stopping",
                "terminated"
                ]
            }
        
    
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_trigger.name
  target_id = aws_lambda_function.lambda.id

  arn = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger.arn
}
