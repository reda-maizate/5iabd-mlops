#module "vpc" {
#  source            = "./modules/vpc"
#  vpc_name          = var.vpc_name
#  subnet_group_name = var.subnet_group_name
#}

module "policy" {
  source = "./modules/policy"
}

module "web" {
  source = "./applications/web"
  ec2_ami           = var.ec2_ami
  ec2_instance_type = var.ec2_instance_type
  ec2_key_name      = var.ec2_key_name
  ec2_volume_size   = var.ec2_volume_size
}

#module "ingress" {
#  depends_on = [
#    module.policy
#  ]
#  source              = "./applications/ingress"
#  queue_name          = var.queue_name_input
#  bucket_name         = var.bucket_name
#  api_description     = var.ingress_api_description
#  api_name            = var.ingress_api_name
#  lambda_name         = var.ingress_lambda_name
#  lambda_policy_json  = module.policy.lambda_iam_json_policy
#  region              = var.AWS_REGION
#  ecr_repository_name = var.ingress_ecr_repository_name
#  operation_name      = var.ingress_operation_name
#}

#module "egress" {
#  source                 = "./applications/egress"
#  queue_name_input       = var.queue_name_input
#  queue_conditions_input = {
#    "ArnEquals" : { "aws:SourceArn" : var.s3_bucket_arn }
#  }
#  queue_name_output       = var.queue_name_output
#  queue_conditions_output = {}
#  s3_bucket_id            = module.ingress.s3_bucket_id
#  depends_on              = [
#    module.ingress
#  ]
#  queue_conditions = ""
#  queue_name       = ""
#}

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