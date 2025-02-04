resource "aws_subnet" "ec2_subnet" {
  vpc_id = var.vpc_id
  assign_ipv6_address_on_creation = false
  cidr_block= var.cidr_block
  
  # availability_zone_id = var.AZ
  availability_zone = var.AZ

  map_public_ip_on_launch= var.isPublic
  tags = {
    Name = var.subnet_name
  }
}




