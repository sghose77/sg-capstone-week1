output "load_balancer_address" {
  value = aws_lb.sg-lb.dns_name
}

output "load_balancer_id" {
  value = aws_lb.sg-lb.id
}
