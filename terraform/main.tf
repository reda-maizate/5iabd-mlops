module "vpc" {
  source                  = "./modules/vpc"
  vpc_name                = var.vpc_name
  subnet_group_name       = var.subnet_group_name
}

module "policy" {
  source = "./modules/policy"
}

module "ingress" {
  source                  = "./applications/ingress"
  #queue_name              = var.queue_name
  bucket_name             = var.bucket_name
  # ingress_api_description = var.ingress_api_description
  # ingress_api_name        = var.ingress_api_name
  # ingress_lambda_arn      = var.ingress_lambda_arn
  # ingress_method          = var.ingress_method
  depends_on                  = [
    module.policy
  ]
}

module "egress" {
  source                      = "./applications/egress"
  queue_name                  = var.queue_name
  sns_topic_name              = var.sns_topic_name
  #sns_vpc_endpoint            = var.sns_vpc_endpoint
  s3_bucket_arn               = module.ingress.s3_bucket_arn
  s3_bucket_id                = module.ingress.s3_bucket_id
  eks_cluster_iam_arn         = module.policy.eks_cluster_iam_arn
  depends_on                  = [
    module.ingress
  ]
}

module "ml" {
  source              = "./applications/ml"
  eks_cluster_name    = var.eks_cluster_name_ml
  eks_cluster_iam_arn = module.policy.eks_cluster_iam_arn
  subnets_id          = module.vpc.subnets_id

  depends_on         = [
    module.vpc,
    module.policy
  ]
}