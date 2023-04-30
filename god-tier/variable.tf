#AWS PROVIDER AND NAMESPACE VARIABLE
variable "provider_region" {
  type = string
}
variable "provider_profile" {
  type = string
}
variable "namespace" {
  type = string
}
#VPC VARIABLE
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
variable "eip_description" {
  type = map(any)
}
variable "nat_description" {
  type = map(any)
}
variable "route_table_cidr" {
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
#SECRET MANAGER VARIABLE
variable "sm_secret_id" {
  type = string
}
#RDS VARIABLES
variable "rds_identifier" {
  type = string
}
variable "rds_engine" {
  type = string
}
variable "rds_engine_version" {
  type = string
}
variable "rds_instance_class" {
  type = string
}
variable "rds_allocated_storage" {
  type = number
}
variable "rds_storage_type" {
  type = string
}
# variable "rds_db_name" {
#   type = string
# }
# variable "rds_username" {
#   type = string
# }
# variable "rds_password" {
#   type = string
# }
# variable "rds_vpc_security_group_ids" {
#   type = list(any)
# }
variable "rds_parameter_group_name" {
  type = string
}
variable "rds_skip_final_snapshot" {
  type = bool
}
variable "rds_publicly_accessible" {
  type = bool
}
#DB_SUBNET_GROUP
variable "db_subnet_group_name" {
  type = string
}