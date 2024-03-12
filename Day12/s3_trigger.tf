resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]  
  }

  depends_on = [aws_lambda_permission.allow_s3_to_invoke_lambda]
}
