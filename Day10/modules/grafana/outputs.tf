output "grafana_public_ip" {
  value = aws_instance.grafana.public_ip
  description = "The public IP address of the web server"
}