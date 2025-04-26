output "vpc_id" {
  value = aws_vpc.sg-vpc.id
}

output "subnet_a_id" {
  value = aws_subnet.sg-subnet-1.id
}

output "subnet_b_id" {
  value = aws_subnet.sg-subnet-2.id
}
