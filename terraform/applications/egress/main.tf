module "sqs" {
    source                      =   "../../modules/sqs"
    queue_name                  =   var.queue_name 
    queue_conditions            =   var.queue_conditions
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