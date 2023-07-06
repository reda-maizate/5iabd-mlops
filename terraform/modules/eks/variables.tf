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
  description = "subnet ids"
  type        = list
  default     = []
}