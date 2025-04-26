resource "aws_lb" "sg-lb" {
  name               = "${var.project}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.allow_http_id]
  subnets            = [var.subnet_a_id, var.subnet_b_id]
  
  tags = {
    Name = "sg-week1-lb"
    Training_week = "Week 1"
    Phase = "Capstone project"
    Solution = "website with modules"
  }
}
