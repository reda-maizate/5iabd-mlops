module "eks_cluster" {
    source                  = "../../modules/eks"
    eks_cluster_name        = var.eks_cluster_name
    eks_cluster_iam_arn     = var.eks_cluster_iam_arn
    subnet_ids              = var.subnet_ids
}

resource "null_resource" "wait_for_cluster" {
  depends_on = [module.eks_cluster]

  provisioner "local-exec" {
    command = "sleep 60"  # Attendez 60 secondes pour que le cluster soit prêt
  }
}