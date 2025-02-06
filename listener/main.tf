resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  vpc_id = var.vpc_id
  port = var.port
  protocol = var.protocol
  health_check {
    port = var.port
    path = "/"
    timeout = 20
    interval = 25
    unhealthy_threshold = 2
    healthy_threshold = 2
  }

}

resource "aws_lb_listener" "external_lb_listener" {

  load_balancer_arn = var.load_balancer_arn
  port = var.port
  protocol = var.protocol
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
    
}


