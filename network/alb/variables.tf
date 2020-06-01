data "aws_caller_identity" "current" {}

variable "target_group_name" {
  description = "The name of the target group"
  type = string
}

variable "target_group_protocol" {
  description = "Target group protocol, default: HTTPS"
  default = "HTTPS"
  type = string
}
variable "vpc_id" {
  description = "VPC id for alb"
  type = string
}

variable "subnets" {
  description = "subnet id for the alb"
  type = list(string)
}

variable "target_type" {
  description = "Target group target type, default: instances"
  type = string
  default = "instance"
}

variable "lb_name" {
  description = "The name of the Load Balancer"
  type = string
}

variable "internal" {
  description = "Is the Load Balancer internal? false if it is external"
  type = bool
  default = false
}

variable "load_balancer_type" {
  description = "What type of this load balancer will be, application/network?"
  default = "application"
  type = string
}

variable "security_groups" {
  description = "Security group id attactch to this load balancer"
  type = list(string)
}

variable "listener_protocol" {
  description = "Listener protocol"
  type = string
  default = "HTTPS"
}

variable "listener_port" {
  description = "Listener port"
  type = string
  default = "443"
}

variable "ssl_policy" {
  description = "Listener SSL policy"
  type = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  description = "Certificate Arn for HTTPS Listener"
  type = string
}

variable "load_balancer_tags" {
  description = "Tags for Load Balancer"
  type = map
}

variable "autoscaling_group_name" {
  description = "Auto scaling group arn to attach the target group"
  type = string
}

variable "load_balancer_log_bucket" {
  description = "Where Load balancer access log location store"
  type = string
}



















