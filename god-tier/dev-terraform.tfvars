#INSTANCE TFVARS
# ami           = "ami-06c4532923d4ba1ec"
# instance_type = ["t2.micro"]
#AWS PROVIDER AND NAMESPACE TFVARS
provider_region  = "us-east-2"
provider_profile = "default"
namespace        = "Dev"
#VPC TFVARS
vpc_cidr_block = "10.0.0.0/16"
vpc_tags = {
  Name    = "VPC"
  Worker  = "employ678@gmail.com"
  Purpose = "Terraform Testing in Work Environment DEV"
  Enddate = "99-09-9999"
}
vpc_public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets_az    = ["us-east-2a", "us-east-2b"]
vpc_private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
vpc_private_subnets_az   = ["us-east-2b", "us-east-2c"]
pub_sub_tag = {
  Type = "Internet Facing"
}
pri_sub_tag = {
  Type = "Internal"
}
pub_map_public_ip_on_launch = true
pri_map_public_ip_on_launch = false
igw_description = {
  Name = "IGW"
}
eip_description = {
  Name = "EIP"
}
nat_description = {
  Name = "NAT"
}
route_table_cidr = "0.0.0.0/0"
#SECURITY GROUP TFVARS
aws_sg_name            = "sg"
aws_sg_description     = "test sg"
sg_ports               = [22, 80, 8080, 3306]
sg_ingress_description = "SSH from VPC"
#SECRET MANAGER TFVARS
sm_secret_id = "SECRET MANAGER NAME FROM AWS"
#RDS TFVARS
rds_identifier        = "rds-db-instance"
rds_engine            = "mariadb"
rds_engine_version    = "10.3"
rds_instance_class    = "db.t2.micro"
rds_allocated_storage = 20
rds_storage_type      = "gp2"
# rds_db_name = "${jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["db_name"]}"
# rds_username = "${jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["username"]}"
# rds_password = "${jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["password"]}"
rds_parameter_group_name = "default.mariadb10.3"
rds_skip_final_snapshot  = true
rds_publicly_accessible  = false
#DB_SUBNET_GROUP TFVARS
db_subnet_group_name = "rds-db-subnet-group-name"