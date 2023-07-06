module "ingress_api_gateway" {
  depends_on  = [module.s3]
  source      = "../../modules/api_gateway"
  api_name    = var.ingress_api_name
  description = var.ingress_api_description
  lambda_arn  = var.ingress_lambda_arn
  method      = var.ingress_method
}

module "lambda_pre_signed_url" {
  source             = "../../modules/lambda"
  lambda_name        = var.lambda_name
  lambda_policy_json = var.lambda_policy_json
  image_uri          = var.image_uri
  memory_size        = var.memory_size
  timeout            = var.timeout
  s3_bucket_name     = module.s3.bucket_id
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = var.bucket_name
}

module "sqs" {
  depends_on    = [module.s3]
  source        = "../../modules/sqs"
  queue_name    = var.queue_name
  s3_bucket_arn = module.s3.bucket_arn
}