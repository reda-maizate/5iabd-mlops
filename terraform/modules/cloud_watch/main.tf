resource "aws_cloudwatch_log_group" "cloud_watch" {
  name = var.aws_cloud_watch_name
  retention_in_days = 7
}