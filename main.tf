
provider "aws" {

  region = "us-east-1"
}


resource "aws_vpc" "proj_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name= "proj-vpc"
    }

}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.proj_vpc.id
}

resource "aws_nat_gateway" "ec2_nategateway" {
  subnet_id = module.public_subnet1.subnet_id
  allocation_id = aws_eip.nat-eip.id
  tags = {
    Name="nat=gateway"
  }

}

resource "aws_security_group" "lb_security_group" {
  
  name = "ec2-security-group"
  vpc_id= aws_vpc.proj_vpc.id
  
  
    # Allow Squid Proxy Port (If Instance is a Proxy)
  ingress {
    from_port   = 3128
    to_port     = 3128
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
    ingress{
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

    ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

    egress{
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}


resource "aws_eip" "nat-eip" {
    domain = "vpc"
}




