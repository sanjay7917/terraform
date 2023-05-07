data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example" {
  name               = var.aws_iam_cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.example.name
}
resource "aws_eks_cluster" "example" {
  name = var.aws_eks_cluster_name
  version = var.aws_eks_cluster_version
  role_arn = aws_iam_role.example.arn

  vpc_config {
    subnet_ids = [var.pub_sub_a_id, var.pub_sub_b_id]
    security_group_ids = [var.security_group_id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}
#OIDC
resource "aws_eks_identity_provider_config" "example" {
  cluster_name = aws_eks_cluster.example.name

  oidc {
    client_id                     = "sts.amazonaws.com"
    identity_provider_config_name = "example"
    issuer_url = "https://oidc.eks.us-east-2.amazonaws.com/id/example"
  }
}
#NODE GROUP
resource "aws_iam_role" "exam" {
  name = var.aws_iam_node_role_name

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.exam.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.exam.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.exam.name
}
resource "aws_key_pair" "key" {
  key_name   = var.aws_key_pair_name
  public_key = file("${path.module}/id_rsa.pub")
}
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = var.aws_eks_node_name
  node_role_arn   = aws_iam_role.exam.arn
  subnet_ids = [var.pub_sub_a_id, var.pub_sub_b_id]
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = [var.aws_eks_node_group_type]
  ami_type       = var.aws_eks_node_group_ami_type

  remote_access {
    ec2_ssh_key = aws_key_pair.key.key_name
    source_security_group_ids = [var.security_group_id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
