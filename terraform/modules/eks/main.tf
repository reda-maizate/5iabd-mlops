resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = var.eks_cluster_iam_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_name
}