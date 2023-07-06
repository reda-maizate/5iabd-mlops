module "vpc" {
  source            = "./modules/vpc"
  vpc_name          = var.vpc_name
  subnet_group_name = var.subnet_group_name
}

module "policy" {
  source = "./modules/policy"
}

module "ingress" {
  source                    = "./applications/ingress"
  #queue_name               = var.queue_name
  bucket_name               = var.bucket_name
  ingress_api_description   = var.ingress_api_description
  ingress_api_name          = var.ingress_api_name
  ingress_lambda_arn        = module.
  ingress_method            = var.ingress_method
  depends_on                = [
    module.policy
  ]
}

module "egress" {
  source                      = "./applications/egress"
  queue_name_input            = var.queue_name_input
  queue_conditions_input       = {
    "ArnEquals": { "aws:SourceArn": "${var.s3_bucket_arn}" }
  } 
  queue_name_output           = var.queue_name_output
  queue_conditions_output      = { }
  s3_bucket_id                = module.ingress.s3_bucket_id
  depends_on                  = [
    module.ingress
  ]
}

# module "ml" {
#   source              = "./applications/ml"
#   eks_cluster_name    = var.eks_cluster_name_ml
#   eks_cluster_iam_arn = module.policy.eks_cluster_iam_arn
#   subnet_ids         = module.vpc.subnet_ids

#   depends_on         = [
#     module.vpc,
#     module.policy
#   ]
# }