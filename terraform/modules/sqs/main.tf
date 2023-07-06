resource "aws_sqs_queue" "sqs_queue" {
    name                          =   var.queue_name
    policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Id": "sqspolicy",
        "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "sqs:SendMessage",
            "Resource": "arn:aws:sqs:*:*:${var.queue_name}",
            "Condition": ${var.queue_conditions}
        }]
    }
  POLICY
}