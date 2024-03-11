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
      SNS_TOPIC_ARN = aws_sns_topic.demo-topic.arn
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "test-demo-bucket-76768768768789790890890901"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]  
  }

  depends_on = [aws_lambda_permission.allow_s3_to_invoke_lambda]
}

resource "aws_lambda_permission" "allow_s3_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}
