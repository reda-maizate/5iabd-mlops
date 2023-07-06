variable "eks_cluster_name" {
  description = "eks cluster name"
  type        = string
  default     = ""
}

variable "eks_cluster_iam_arn" {
  description = "eks cluster iam arn"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "subnets ids"
  type        = list
  default     = []
}

variable "aws_cloud_watch_name" {
  description = "eks cloud watch name"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "Default region for provider"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = ""
  type        = string
  default     = ""
}

variable "aws_account_id" {
  description = ""
  type        = string
  default     = ""
}

variable "aws_account_id" {
  description = "account id of aws"
  type        = string
  default     = ""
  sensitive   = true
}

variable "sqs_input_queue" {
  description = "account id of aws"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ecs_port" {
  description = "ecs port"
  type        = number
  default     = 0
}

variable "ecs_cpu" {
  description = "ecs cpu"
  type        = number
  default     = 0
}

variable "ecs_memory" {
  description = "ecs memory"
  type        = number
  default     = 0
}

variable "ecs_network_mode" {
  description = "ecs network mode"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "subnet name"
  type        = string
  default     = ""
}

variable "subnet_public_id" {
  description = "subnet public id"
  type        = string
  default     = ""
}

variable "subnet_private_id" {
  description = "subnet private id"
  type        = string
  default     = ""
}

variable "ecs_role" {
  description = "iam role ecs arn"
  type        = string
  default     = ""
}