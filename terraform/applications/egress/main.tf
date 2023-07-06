module "sns"{
    source              =   "../../modules/sns"
    sns_topic_name      =   var.sns_topic_name
#    sns_vpc_endpoint    =   var.sns_vpc_endpoint
}

module "sqs" {
    source                      =   "../../modules/sqs"
    queue_name                  =   var.queue_name 
    s3_bucket_arn               =   var.s3_bucket_arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket          = var.s3_bucket_id

    queue {
        id              = "image-upload-event"
        queue_arn       = module.sqs.sqs_queue_arn
        events          = ["s3:ObjectCreated:*"]
    }
    depends_on      = [
        module.sqs
    ]
}