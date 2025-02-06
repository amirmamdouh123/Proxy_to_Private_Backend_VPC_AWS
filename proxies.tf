module "proxy1" {
  source = "./ec2"
  image_id = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  isPublic = true
  security_group_id = aws_security_group.lb_security_group.id
  subnet_id = module.public_subnet1.subnet_id
  isProxy = true
  proxy_traffic_target = module.internal_lb.lb_dns_name
    key_pair_name= aws_key_pair.ec2_key_pair.key_name


}

module "proxy2" {
  source = "./ec2"
  image_id = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  isPublic = true
  security_group_id = aws_security_group.lb_security_group.id
  subnet_id = module.public_subnet2.subnet_id
  isProxy = true
  proxy_traffic_target = module.internal_lb.lb_dns_name
    key_pair_name= aws_key_pair.ec2_key_pair.key_name

}