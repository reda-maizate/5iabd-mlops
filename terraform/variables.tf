# providers
variable AWS_ACCESS_KEY {}
variable AWS_SECRET_KEY {}  
variable AWS_ACCOUNT_ID {}
variable AWS_REGION {}

# Egress module
variable "queue_name" {}
variable "sns_topic_name" {}

# Ingress module
variable "bucket_name" {}
variable "ingress_api_name" {}
variable "ingress_api_description" {}
variable "ingress_lambda_arn" {}
variable "ingress_method" {}

# EKS
variable "eks_cluster_name_ml" {
  
}

# VPC
variable "vpc_name" {
    type        = string
    description = "vpc name"
    default     = ""
}

variable "subnet_group_name" {
    type        = string
    description = "subnet group name"
    default     = ""
}