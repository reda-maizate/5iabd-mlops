#module "ingress" {
#  source                  = "./applications/ingress"
#  queue_name              = var.queue_name
#  bucket_name             = var.bucket_name
#  ingress_api_description = var.ingress_api_description
#  ingress_api_name        = var.ingress_api_name
#  ingress_lambda_arn      = var.ingress_lambda_arn
#  ingress_method          = var.ingress_method
#}

module "egress" {
  source                     = "./applications/egress"
  queue_name                 = var.queue_name
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  sns_topic_name             = var.sns_topic_name
  sns_vpc_endpoint           = var.sns_vpc_endpoint
  s3_bucket_arn              = var.s3_bucket_arn
  s3_bucket_id               = var.s3_bucket_id
}