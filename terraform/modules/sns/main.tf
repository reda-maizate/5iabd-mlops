resource "aws_sns_topic" "sns_topic" {
  name      = var.sns_topic_name
}


# resource "aws_sns_topic_subscription" "sns_subscription" {
#   topic_arn = aws_sns_topic.sns_topic.arn
#   protocol  = "sns"
#   endpoint  = aws_vpc_endpoint.sns_endpoint.
# }