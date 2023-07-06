resource "aws_sqs_queue" "sqs_queue" {
    name                          =   var.queue_name
    delay_seconds                 =   var.delay_seconds
    max_message_size              =   var.max_message_size
    message_retention_seconds     =   var.message_retention_seconds
    visibility_timeout_seconds    =   var.visibility_timeout_seconds
    policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Id": "sqspolicy",
        "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "sqs:SendMessage",
            "Resource": "arn:aws:sqs:*:*:s3-event-queue",
            "Condition": {
                "ArnEquals": { "aws:SourceArn": "${var.s3_bucket_arn}" }
            }
        }]
    }
  POLICY
}