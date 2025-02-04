module "external_lb" {
  source = "./load_balancer"
  lb_name = "lb-external"
  isInternal = false
  load_balancer_type = "network"
  external_lb_subnets =  [module.public_subnet1.subnet_id ,module.public_subnet2.subnet_id]
  external_lb_security_groups = [ aws_security_group.lb_security_group.id ]
}



module "internal_lb" {
  source = "./load_balancer"
  lb_name = "lb-internal"
  isInternal = true
  load_balancer_type = "application"
  external_lb_subnets =  [ module.private_subnet1.subnet_id ,module.private_subnet2.subnet_id ]
  external_lb_security_groups = [ aws_security_group.lb_security_group.id ]

depends_on = [ module.external_lb.lb_content ]
}


