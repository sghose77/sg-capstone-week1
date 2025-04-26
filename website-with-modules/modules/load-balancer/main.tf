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

resource "aws_lb_target_group" "sg-lb-target-group" {
  name        = "${var.project}-alb-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.sg-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
