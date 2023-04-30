module "vpc_module" {
  source    = "./modules/vpc"
  namespace = var.namespace
  #VPC VARIABLE PASS
  vpc_cidr_block              = var.vpc_cidr_block
  vpc_tags                    = var.vpc_tags
  vpc_public_subnets_cidr     = var.vpc_public_subnets_cidr
  vpc_public_subnets_az       = var.vpc_public_subnets_az
  pub_map_public_ip_on_launch = var.pub_map_public_ip_on_launch
  pub_sub_tag                 = var.pub_sub_tag
  vpc_private_subnets_cidr    = var.vpc_private_subnets_cidr
  vpc_private_subnets_az      = var.vpc_private_subnets_az
  pri_sub_tag                 = var.pri_sub_tag
  pri_map_public_ip_on_launch = var.pri_map_public_ip_on_launch
  igw_description             = var.igw_description
  eip_description             = var.eip_description
  nat_description             = var.nat_description
  route_table_cidr            = var.route_table_cidr
  #SECURITY GROUP VARIABLE PASS
  aws_sg_name            = var.aws_sg_name
  aws_sg_description     = var.aws_sg_description
  sg_ports               = var.sg_ports
  sg_ingress_description = var.sg_ingress_description
}
# module "vm_module" {
#   source = "./modules/vms"
#   img               = var.ami
#   vm_size           = var.instance_type
# }