#CREATE VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "myvpc"
  }
}
#CREATE PUBLIC SUBNET
resource "aws_subnet" "pub_sub" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.1.0/24"
}
#CREATE PRIVATE SUBNET
resource "aws_subnet" "pri_sub" {
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "us-east-2b"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
}

#CREATE IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "IGW"
  }
}

#CREATE PUBLIC ROUTE TABLE
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

#ASSOCIATE PUBLIC SUBNET TO PUBLIC ROUTE TABLE
resource "aws_route_table_association" "pub_rts" {
  subnet_id = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.pub_rt.id
}

#CREATE PRIVATE ROUTE TABLE
resource "aws_route_table" "pri_rt" {
    vpc_id = aws_vpc.myvpc.id
}

#ASSOCIATE PRIVATE SUBNET TO PUBLIC ROUTE TABLE
resource "aws_route_table_association" "pri_rts" {
  subnet_id = aws_subnet.pri_sub.id
  route_table_id = aws_route_table.pri_rt.id
}