module "ec2_backend1" {
  source = "./ec2"
  image_id = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"

  isPublic = false
  security_group_id = aws_security_group.lb_security_group.id
  subnet_id = module.private_subnet1.subnet_id
  isProxy = false
  proxy_traffic_target = "null"       #it's not a proxy 
  key_pair_name= aws_key_pair.ec2_key_pair.key_name

}

module "ec2_backend2" {
  source = "./ec2"
  image_id = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  isPublic = false
  security_group_id = aws_security_group.lb_security_group.id
  subnet_id = module.private_subnet2.subnet_id
  isProxy = false
  proxy_traffic_target = "null"      #it's not a proxy 
  key_pair_name= aws_key_pair.ec2_key_pair.key_name
}