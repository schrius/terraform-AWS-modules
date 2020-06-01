terraform {
    required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-1"
}

data "external" "available_port" {
    program = ["python3", "${path.module}/uniquePort.py"]
    query = {
      target_group_name = var.target_group_name
    }
}

resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  port = data.external.available_port.result.port
  protocol = var.target_group_protocol
  vpc_id = var.vpc_id
  target_type = var.target_type
}

resource "aws_lb" "load_balancer" {
  name = var.lb_name
  internal = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups = var.security_groups
  subnets = var.subnets

  access_logs {
    bucket = var.load_balancer_log_bucket
    enabled = true
  }

  tags = var.load_balancer_tags
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = var.listener_port
  protocol = var.listener_protocol
  ssl_policy = var.ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.autoscaling_group_name
  alb_target_group_arn = aws_lb_target_group.target_group.arn
}

resource "aws_shield_protection" "shield" {
  name = var.lb_name
  resource_arn = aws_lb.load_balancer.arn
}

