#VPC
resource "aws_vpc" "example" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "example-vpc"
  }
}
resource "aws_subnet" "public_a" {
  cidr_block              = var.a_pub_sub_cidr_block
  vpc_id                  = aws_vpc.example.id
  availability_zone       = var.vpc_sub_a_region
  map_public_ip_on_launch = true
  tags = {
    Name = "example-public-a"
  }
}
resource "aws_subnet" "public_b" {
  cidr_block              = var.b_pub_sub_cidr_block
  vpc_id                  = aws_vpc.example.id
  availability_zone       = var.vpc_sub_b_region
  map_public_ip_on_launch = true
  tags = {
    Name = "example-public-b"
  }
}
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "example-igw"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block = var.internet_cidr_block
    gateway_id = aws_internet_gateway.example.id
  }
  tags = {
    Name = "example-public-route-table"
  }
}
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
#SECURITY GROUP
resource "aws_security_group" "sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.example.id
  dynamic "ingress" {
    for_each = [22, 80, 8080]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}