resource "aws_lb" "ec2_load_balancer" {
  name = var.lb_name
  internal = var.isInternal
  load_balancer_type = var.load_balancer_type
  tags = {
    Name = var.lb_name
  }



  subnets = var.external_lb_subnets
  security_groups = var.external_lb_security_groups


  lifecycle {
    create_before_destroy = true
  }
}