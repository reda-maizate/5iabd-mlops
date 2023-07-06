variable "queue_name" {
  type        = string
  description = "Name of the SQS queue"
}

variable "s3_bucket_id" {
  type        = string
  description = "bucket id"
}

variable "queue_conditions" {
  type        = map
}