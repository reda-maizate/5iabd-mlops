variable "queue_name" {
  type        = string
  description = "Name of the SQS queue"
}

variable "delay_seconds" {
  type        = number
  description = "The time in seconds that the delivery of all messages in the queue is delayed"
  default     = 0
}

variable "max_message_size" {
  type        = number
  description = "The maximum size for a message that can be stored in the queue, in bytes"
  default     = 262144
}

variable "message_retention_seconds" {
  type        = number
  description = "The number of seconds Amazon SQS retains a message"
  default     = 345600
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "The visibility timeout for the queue, in seconds"
  default     = 30
}
