output "subnet_id" {
    description = "Subnet ID"
    value = aws_subnet.main.id
}

output "security_group_id" {
    description = "Security Group ID"
    value = aws_security_group.security-group.id
}