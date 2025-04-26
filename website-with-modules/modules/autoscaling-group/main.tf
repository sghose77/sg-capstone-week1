resource "aws_launch_configuration" "sg-launch-configuration" {
  name                        = "${var.project}-launch-config"
  image_id                    = var.image-id[var.region]
  instance_type               = var.instance_type
  security_groups             = [var.allow_http_id, var.allow_ssh_id]
  associate_public_ip_address = var.add_public_ip

  user_data = file(var.startup_script)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "sg-auto-scaling" {
  name                 = "${var.project}-asg"
  min_size             = var.instance_count_min
  max_size             = var.instance_count_max
  health_check_type    = "ELB"
  #load_balancers       = [var.load_balancer_id]
  launch_configuration = aws_launch_configuration.sg-launch-configuration.name

  vpc_zone_identifier = [
    var.subnet_a_id,
    var.subnet_b_id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.project}-webserver"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "sg-asa" {
  autoscaling_group_name = aws_autoscaling_group.sg-auto-scaling.id
  lb_target_group_arn    = var.load_balancer_id
}
