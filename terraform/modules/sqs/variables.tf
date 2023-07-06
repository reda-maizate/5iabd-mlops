variable "queue_name" {
  type        = string
  description = "Name of the SQS queue"
}

variable "s3_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket to which the SQS queue will send messages"
}