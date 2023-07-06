
module "egress"{
    source                      =   "./applications/egress"
    queue_name                  =   var.queue_name 
    delay_seconds               =   var.delay_seconds
    max_message_size            =   var.max_message_size
    message_retention_seconds   =   var.message_retention_seconds 
    visibility_timeout_seconds  =   var.visibility_timeout_seconds
    sns_topic_name              =   var.sns_topic_name
    sns_vpc_endpoint            =   var.sns_vpc_endpoint
    s3_bucket_id                =   var.s3_bucket_id
}