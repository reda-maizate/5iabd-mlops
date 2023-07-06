resource "aws_security_group" "security_group" {
  vpc_id = var.AWS_VPC_ID
  name   = var.AWS_VPC_NAME

  ingress {
    from_port   = var.AWS_INGRESS_FROM_PORT
    to_port     = var.AWS_INGRESS_TO_PORT
    protocol    = var.AWS_INGRESS_PROTOCOL
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.AWS_EGRESS_FROM_PORT
    to_port     = var.AWS_EGRESS_TO_PORT
    protocol    = var.AWS_EGRESS_PROTOCOL
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.AWS_VPC_NAME
  }
}