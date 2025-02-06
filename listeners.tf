###################################################33
#Create the external listener and target group   attached to the external lb
module "external_listener_target_group" {
    source = "./listener"
    vpc_id = aws_vpc.proj_vpc.id
    protocol = "HTTP"
    load_balancer_arn = module.external_lb.lb_content.arn
    port = 80
    target_group_name = "external-target-group"
}


# Attach the external load balancer target group  to proxy1
resource "aws_lb_target_group_attachment" "proxy_target_attachment1" {
# count               = var.instance_type == "proxy" ? 1 : 0
  target_group_arn    = module.external_listener_target_group.target_group.arn
  target_id           =  module.proxy1.ec2_instance_id # backend ec2 instance1
  port                = 80
}

# Attach the external load balancer target group to proxy2
resource "aws_lb_target_group_attachment" "proxy_target_attachment2" {
# count               = var.instance_type == "proxy" ? 1 : 0
  target_group_arn    = module.external_listener_target_group.target_group.arn
  target_id           =  module.proxy2.ec2_instance_id# backend ec2 instance2
  port                = 80
}




###################################################################
#Create the internal listener and target group   attached to the internal lb
module "internal_listener_target_group" {
    source = "./listener"
    vpc_id = aws_vpc.proj_vpc.id
    protocol = "HTTP"
    load_balancer_arn = module.internal_lb.lb_content.arn
    port = 80
    target_group_name = "internal-target-group"

}

# Attach the external load balancer target group with the internal load balancer
resource "aws_lb_target_group_attachment" "backend_target_attachment1" {
# count               = var.instance_type == "proxy" ? 1 : 0
  target_group_arn    = module.internal_listener_target_group.target_group.arn
  target_id           =  module.ec2_backend1.ec2_instance_id # backend ec2 instance1
  port                = 80
}

# Attach the external load balancer target group with the internal load balancer
resource "aws_lb_target_group_attachment" "backend_target_attachment2" {
# count               = var.instance_type == "proxy" ? 1 : 0
  target_group_arn    = module.internal_listener_target_group.target_group.arn
  target_id           =  module.ec2_backend2.ec2_instance_id# backend ec2 instance2
  port                = 80
}