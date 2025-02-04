output "listener" {
  value = aws_lb_listener.external_lb_listener
}

output "target_group" {
  value = aws_lb_target_group.target_group
  }