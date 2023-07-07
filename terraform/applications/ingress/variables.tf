variable "api_name" {}

variable "api_description" {}

variable "integration_method" {
  default = "POST"
}

variable "method" {
  default = "GET"
}

variable "bucket_name" {}

variable "queue_name" {}

variable "lambda_name" {}

variable "lambda_policy_json" {}

variable "memory_size" {
  default = 2048
}

variable "timeout" {
  default = 190
}

variable "region" {}

variable "ecr_repository_name" {}

variable "operation_name" {}