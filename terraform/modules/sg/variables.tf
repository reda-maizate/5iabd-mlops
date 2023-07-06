variable "aws_vpc_id" {
  description = "vpc id"
  type        = string
  default     = ""
}

variable "aws_vpc_name" {
  description = "vpc name"
  type        = string
  default     = ""
}

variable "aws_ingress_from_port" {
  description = "ingress from port"
  type        = number
  default     = 0
}

variable "aws_ingress_to_port" {
  description = "ingress to port"
  type        = number
  default     = 0
}

variable "aws_ingress_protocol" {
  description = "ingress protocol"
  type        = string
  default     = ""
}

variable "aws_egress_from_protocol" {
  description = "egress from port"
  type        = number
  default     = 0
}

variable "aws_egress_to_port" {
  description = "egress to port"
  type        = number
  default     = 0
}

variable "aws_egress_protocol" {
  description = "egress protocol"
  type        = string
  default     = ""
}