variable "sns_topic_name" {
  description = "sns topic name"
  type        = string
  default     = ""
}

# variable "sns_vpc_endpoint" {
#   description = "sns vpc endpoint"
#   type        = string
#   default     = ""
# }

variable "queue_name" {
  type        = string
  description = "Name of the SQS queue"
}

variable "s3_bucket_id" {
  type        = string
  description = "bucket id"
}

variable "s3_bucket_arn" {
  type        = string
  description = "bucket arn"
}