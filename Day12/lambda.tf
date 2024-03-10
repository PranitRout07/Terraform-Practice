provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "s3_bucket_state_check.py"
  output_path = "s3_bucket_state_check.zip"
}



resource "aws_lambda_function" "lambda" {
  function_name = "s3_bucket_state_check"

  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"

  role    = aws_iam_role.lambda_role_terraform.arn
  handler = "s3_bucket_state_check.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.demo-topic.id
    }
  }
}


resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name = "s3_bucket_state_change_trigger"
  event_pattern = jsonencode({
    "source": ["aws.s3"],
    "detail-type": ["AWS API Call via CloudTrail"],
    "detail": {
      "eventSource": ["s3.amazonaws.com"],
      "eventName": [
        "AbortMultipartUpload",
        "CompleteMultipartUpload",
        "CopyObject",
        "CreateBucket",
        "CreateMultipartUpload",
        "DeleteBucket",
        "DeleteBucketCors"
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
