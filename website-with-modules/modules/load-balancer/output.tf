output "load_balancer_address" {
  value = aws_lb.sg-lb.dns_name
}

output "load_balancer_id" {
  value = aws_lb.sg-lb.id
}

output "sg-lb-target-group_id" {
  value = aws_lb_target_group.sg-lb-target-group.id
}
