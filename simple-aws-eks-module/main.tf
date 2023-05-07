provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = "10.0.0.0/16"
  a_pub_sub_cidr_block = "10.0.1.0/24"
  b_pub_sub_cidr_block = "10.0.2.0/24"
  internet_cidr_block  = "0.0.0.0/0"
  vpc_sub_a_region           = "us-east-2a"
  vpc_sub_b_region           = "us-east-2b"
}
module "eks" {
  source                      = "./modules/eks"
  aws_iam_cluster_role_name   = "eks-cluster-example"
  aws_eks_cluster_name        = "example-cluster"
  aws_eks_cluster_version     = "1.24"
  aws_iam_node_role_name      = "eks-node-group-example"
  aws_key_pair_name           = "terra"
  aws_eks_node_name           = "my-node-group"
  aws_eks_node_group_type     = "t3.medium"
  aws_eks_node_group_ami_type = "AL2_x86_64"
  pub_sub_a_id                = module.vpc.pub_sub_a_id
  pub_sub_b_id                = module.vpc.pub_sub_b_id
  security_group_id           = module.vpc.security_group_id
}