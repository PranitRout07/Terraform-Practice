resource "aws_iam_role" "lambda_role_terraform" {
  name = "lambda-sns-001"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

}



// attaching permissions
resource "aws_iam_policy_attachment" "cloudwatch_policy" {
  name       = "cloudwatch-policy"
  roles      = [aws_iam_role.lambda_role_terraform.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
resource "aws_iam_policy_attachment" "sns_policy" {
  name       = "sns-policy"
  roles      = [aws_iam_role.lambda_role_terraform.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}
resource "aws_iam_policy_attachment" "ec2_policy" {
  name       = "ec2-policy"
  roles      = [aws_iam_role.lambda_role_terraform.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
resource "aws_iam_policy_attachment" "cloudwatch_logs_policy" {
  name       = "cloudwatch-logs-policy"
  roles      = [aws_iam_role.lambda_role_terraform.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


