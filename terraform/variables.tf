# Egress module
variable "queue_name" {}
variable "delay_seconds" {}
variable "max_message_size" {}
variable "message_retention_seconds" {}
variable "visibility_timeout_seconds" {}
variable "sns_topic_name" {}
variable "sns_vpc_endpoint" {}
variable "s3_bucket_arn" {}
variable "s3_bucket_id" {}

# Ingress module
variable "bucket_name" {}
variable "ingress_api_name" {}
variable "ingress_api_description" {}
variable "ingress_lambda_arn" {}
variable "ingress_method" {}