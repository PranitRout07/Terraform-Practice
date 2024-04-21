//syntax

resource "demo" "name" {
  instance_type = var.environment == "development" ? "t2.micro" : "t2.small"
}