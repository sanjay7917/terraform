#AWS PROVIDER TFVARS
provider_region  = "us-east-2"
provider_profile = "default"
namespace        = "Dev"

#INSTANCE TFVARS
ami           = "ami-06c4532923d4ba1ec"
instance_type = ["t2.micro", "t2.medium", "t2.large", "t2.small", "t3.micro", "t3.large", "t3.medium"]
instance_tags = {
  Name    = "Server"
  Worker  = "employ123@gmail.com"
  Purpose = "Terraform Testing in Work Environment DEV"
  Enddate = "99-09-9999"
}
associate_public_ip_address = true

#EBS VOLUME TFVARS
ebs_availability_zone = ["us-east-2a", "us-east-2b"]
ebs_tags = {
  Name = " "
}
ebs_volume_size = 10
ebs_device_name = "/dev/sdh"

#Application Load Balancer TFVARS
alb_name              = "my-alb"
internal              = false
load_balancer_type    = "application"
target_group_name     = "my-tg"
target_group_protocol = "HTTP"
alb_tg_port           = 80
alb_tg_action_type    = "forward"

#SECURITY GROUP TFVARS
aws_sg_name            = "sg"
aws_sg_description     = "test sg"
sg_ports               = [22, 80, 8080]
sg_ingress_description = "SSH from VPC"

#VPC TFVARS
vpc_cidr_block = "10.0.0.0/16"
vpc_tags = {
  Name    = "MyVPC"
  Worker  = "employ678@gmail.com"
  Purpose = "Terraform Testing in Work Environment DEV"
  Enddate = "99-09-9999"
}
vpc_public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets_az    = ["us-east-2a", "us-east-2b"]
vpc_private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
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
route_table_cidr = "0.0.0.0/0"