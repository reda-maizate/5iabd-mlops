locals {
  ecr_image_tag = "latest"
  account_id    = data.aws_caller_identity.current.account_id
}

data aws_caller_identity current {}
data aws_ecr_authorization_token token {}

module "ingress_api_gateway" {
  depends_on         = [module.s3]
  source             = "../../modules/api_gateway"
  api_gateway_name   = var.api_name
  description        = var.api_description
  method             = var.method
  integration_method = var.integration_method
  integration_uri    = module.lambda_pre_signed_url.invoke_lambda_arn
  operation_name     = var.operation_name
}

module "lambda_pre_signed_url" {
  depends_on         = [module.s3, module.ecr]
  source             = "../../modules/lambda_ingress"
  lambda_name        = var.lambda_name
  lambda_policy_json = var.lambda_policy_json
  image_uri          = module.ecr.image_uri
  memory_size        = var.memory_size
  timeout            = var.timeout
  s3_bucket_name     = module.s3.bucket_id
  region             = var.region
}

module "ecr" {
  source                                      = "../../modules/ecr"
  aws_caller_identity_current_account_id      = data.aws_caller_identity.current.account_id
  aws_ecr_authorization_token_token_password  = data.aws_ecr_authorization_token.token.authorization_token
  aws_ecr_authorization_token_token_user_name = data.aws_ecr_authorization_token.token.user_name
  ecr_image_tag                               = local.ecr_image_tag
  ecr_repository_name                         = var.ecr_repository_name
  region                                      = var.region
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.bucket_name
}