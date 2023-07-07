# providers
variable AWS_ACCESS_KEY {}
variable AWS_SECRET_KEY {}  
variable AWS_ACCOUNT_ID {}
variable AWS_REGION {}

# Egress module
#variable "queue_name" {}

# Web module
variable "ec2_ami" {}
variable "ec2_instance_type" {}
variable "ec2_key_name" {}
variable "ec2_volume_size" {}

# Ingress module
variable "bucket_name" {}
variable "ingress_api_name" {}
variable "ingress_api_description" {}
variable "ingress_method" {}
variable "ingress_lambda_name" {}
variable "ingress_ecr_repository_name" {}
variable "queue_name_input" {}
variable "queue_name_output" {}
variable "ingress_operation_name" {}

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