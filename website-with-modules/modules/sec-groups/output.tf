output "allow_ssh_id" {
  value = aws_security_group.sg-ssh-access.id
}

output "allow_http_id" {
  value = aws_security_group.sg-http-access.id
}
