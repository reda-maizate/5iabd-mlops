variable "queue_name" {
  type        = string
  description = "Name of the SQS queue"
}

variable "queue_conditions" {
  type        = map
  description = "queue condition"
}