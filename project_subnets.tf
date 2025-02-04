####################################################################
#Create public subnets and associate with route table to route to internet gateway
module "public_subnet1" {
    source = "./subnet"
    AZ =    "us-east-1a"
    vpc_id = aws_vpc.proj_vpc.id
    cidr_block = "10.0.0.0/24"
    isPublic = true
    subnet_name = "public-subnet1"
}

module "public_subnet2" {
    source = "./subnet"
    AZ =    "us-east-1b"
    vpc_id = aws_vpc.proj_vpc.id
    cidr_block = "10.0.2.0/24"
    isPublic = true
    subnet_name = "public-subnet2"
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.proj_vpc.id
    route {
        gateway_id = aws_internet_gateway.internet_gateway.id
        cidr_block = "0.0.0.0/0"
    }
}

resource "aws_route_table_association" "public_route_table_association1" {
  subnet_id = module.public_subnet1.subnet_id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association2" {
  subnet_id = module.public_subnet2.subnet_id
  route_table_id = aws_route_table.public_route_table.id
}



#########################################################################3
#Create private subnets with no route tables -> No NAT gatway


module "private_subnet1" {
    source = "./subnet"
    AZ =    "us-east-1a"
    vpc_id = aws_vpc.proj_vpc.id
    cidr_block = "10.0.1.0/24"
    isPublic = false
    subnet_name = "private-subnet2"
}

module "private_subnet2" {
    source = "./subnet"
    AZ =    "us-east-1b"
    vpc_id = aws_vpc.proj_vpc.id
    cidr_block = "10.0.3.0/24"
    isPublic = false
    subnet_name = "private-subnet2"
}


resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.proj_vpc.id
    route {
        gateway_id = aws_nat_gateway.ec2_nategateway.id
        cidr_block = "0.0.0.0/0"
    }
}

resource "aws_route_table_association" "private_route_table_association1" {
  subnet_id = module.private_subnet1.subnet_id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_table_association2" {
  subnet_id = module.private_subnet2.subnet_id
  route_table_id = aws_route_table.private_route_table.id
}

