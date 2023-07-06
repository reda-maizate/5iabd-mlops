module "sns"{
    source              =   "../../modules/sns"
    sns_topic_name      =   var.sns_topic_name
    sns_vpc_endpoint    =   var.sns_vpc_endpoint
}

module "sqs" {
    source                      =   "../../modules/sqs"
    queue_name                  =   var.queue_name 
    delay_seconds               =   var.delay_seconds
    max_message_size            =   var.max_message_size
    message_retention_seconds   =   var.message_retention_seconds 
    visibility_timeout_seconds  =   var.visibility_timeout_seconds
}

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = var.s3_bucket_id

    queue {
        queue_arn = module.sqs.sqs_queue_arn
        events    = ["s3:ObjectCreated:*"]
    }
}