resource "aws_key_pair" "new-key" {
  key_name = "new_key"
  public_key = file("${path.module}/id_rsa.pub")
}
