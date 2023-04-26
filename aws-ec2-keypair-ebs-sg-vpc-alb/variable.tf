#AWS PROVIDER VARIABLE
variable "provider_region" {
  type = string
}
variable "provider_profile" {
  type = string
}
variable "namespace" {
  type = string
}

#INSTANCE VARIBALES
variable "ami" {
  type = string
}
variable "instance_type" {
  type = list(any)
}
variable "instance_tags" {
  type = map(any)
}
variable "associate_public_ip_address" {
  type = bool
}

#EBS VOLUME VARIABLES
variable "ebs_availability_zone" {
  type = list(any)
}
variable "ebs_tags" {
  type = map(any)
}
variable "ebs_volume_size" {
  type = number
}
variable "ebs_device_name" {
  type = string
}

#Application Load Balancer VARIABLES
variable "alb_name" {
  type = string
}
variable "internal" {
  type = bool
}
variable "load_balancer_type" {
  type = string
}
variable "target_group_name" {
  type = string
}
variable "target_group_protocol" {
  type = string
}
variable "alb_tg_port" {
  type = number
}
variable "alb_tg_action_type" {
  type = string
}

#SECURITY GROUP VARIABLE
variable "aws_sg_name" {
  type = string
}
variable "aws_sg_description" {
  type = string
}
variable "sg_ports" {
  type = list(any)
}
variable "sg_ingress_description" {
  type = string
}

#VPC VARIABLES
variable "vpc_cidr_block" {
  type = string
}
variable "vpc_tags" {
  type = map(any)
}
variable "vpc_public_subnets_cidr" {
  type = list(any)
}
variable "vpc_public_subnets_az" {
  type = list(any)
}
variable "vpc_private_subnets_cidr" {
  type = list(any)
}
variable "vpc_private_subnets_az" {
  type = list(any)
}
variable "pub_sub_tag" {
  type = map(any)
}
variable "pri_sub_tag" {
  type = map(any)
}
variable "pub_map_public_ip_on_launch" {
  type = bool
}
variable "pri_map_public_ip_on_launch" {
  type = bool
}
variable "igw_description" {
  type = map(any)
}
variable "route_table_cidr" {
  type = string
}