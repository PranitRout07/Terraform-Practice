resource "aws_s3_bucket" "bucket" {
  bucket = "test-demo-bucket-76768768768789790890890901"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}