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

module "rds_module" {
  source = "./modules/rds"
  #RDS VARIABLE PASS
  sm_secret_id             = var.sm_secret_id
  rds_identifier           = var.rds_identifier
  rds_engine               = var.rds_engine
  rds_engine_version       = var.rds_engine_version
  rds_instance_class       = var.rds_instance_class
  rds_storage_type         = var.rds_storage_type
  rds_allocated_storage    = var.rds_allocated_storage
  rds_parameter_group_name = var.rds_parameter_group_name
  rds_skip_final_snapshot  = var.rds_skip_final_snapshot
  rds_publicly_accessible  = var.rds_publicly_accessible
  #DB_SUBNET_GROUP VARIABLE PASS
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = module.vpc_module.vpc_security_group_ids
  pri_sub_ids            = module.vpc_module.pri_sub_ids
}
