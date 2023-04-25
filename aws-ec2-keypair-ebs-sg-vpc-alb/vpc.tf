#CREATE VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name   = lookup(var.vpc_tags, "Name")
    Worker = "employ678@gmail.com"
  }
}
#CREATE PUBLIC SUBNET
resource "aws_subnet" "pub_sub" {
  vpc_id                  = aws_vpc.myvpc.id
  count                   = length(var.vpc_public_subnets_cidr)
  cidr_block              = element(var.vpc_public_subnets_cidr, count.index)
  availability_zone       = element(var.vpc_public_subnets_az, count.index)
  map_public_ip_on_launch = var.pub_map_public_ip_on_launch
  tags                    = merge(var.pub_sub_tag, { Name = "${var.namespace}-PublicSubnet-${count.index + 1}" })
}
resource "aws_subnet" "pri_sub" {
  vpc_id                  = aws_vpc.myvpc.id
  count                   = length(var.vpc_private_subnets_cidr)
  cidr_block              = element(var.vpc_private_subnets_cidr, count.index)
  availability_zone       = element(var.vpc_private_subnets_az, count.index)
  map_public_ip_on_launch = var.pri_map_public_ip_on_launch
  tags                    = merge(var.pri_sub_tag, { Name = "${var.namespace}-PrivateSubnet-${count.index + 1}" })
}
# resource "aws_subnet" "pub_sub1" {
#   vpc_id            = aws_vpc.myvpc.id
#   availability_zone = var.vpc_pub_subnet1_az
#   cidr_block        = var.vpc_pub_subnet1_cidr
# }
# resource "aws_subnet" "pub_sub2" {
#   vpc_id            = aws_vpc.myvpc.id
#   availability_zone = var.vpc_pub_subnet2_az
#   cidr_block        = var.vpc_pub_subnet2_cidr
# }
#CREATE PRIVATE SUBNET
# resource "aws_subnet" "pri_sub" {
#   vpc_id                  = aws_vpc.myvpc.id
#   availability_zone       = var.vpc_pri_subnet_az
#   cidr_block              = var.vpc_pri_subnet_cidr
#   map_public_ip_on_launch = var.pri_map_public_ip_on_launch
# }

#CREATE IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags   = var.igw_description
}

#CREATE PUBLIC ROUTE TABLE
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
}

#ASSOCIATE PUBLIC SUBNET TO PUBLIC ROUTE TABLE
resource "aws_route_table_association" "pub_rts" {
  count          = length(var.vpc_public_subnets_cidr)
  subnet_id      = aws_subnet.pub_sub[count.index].id
  route_table_id = aws_route_table.pub_rt.id
}
# resource "aws_route_table_association" "pub_rts2" {
#   subnet_id      = aws_subnet.pub_sub[1].id
#   route_table_id = aws_route_table.pub_rt.id
# }

#CREATE PRIVATE ROUTE TABLE
resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.myvpc.id
}

#ASSOCIATE PRIVATE SUBNET TO PUBLIC ROUTE TABLE
# resource "aws_route_table_association" "pri_rts" {
#   subnet_id      = aws_subnet.pri_sub.id
#   route_table_id = aws_route_table.pri_rt.id
# }
resource "aws_route_table_association" "pri_rts" {
  count          = length(var.vpc_private_subnets_cidr)
  subnet_id      = aws_subnet.pri_sub[count.index].id
  route_table_id = aws_route_table.pri_rt.id
}