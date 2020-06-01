output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "target_group" {
  value = aws_lb_target_group.target_group
}

output "load_balancer" {
  value = aws_lb.load_balancer
}

output "available_port" {
  value = data.external.available_port.result
}
