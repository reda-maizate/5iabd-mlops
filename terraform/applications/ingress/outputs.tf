output "ingress_api_url" {
  value = module.ingress_api_gateway.api_url
}

output "s3_bucket_id" {
  value = module.s3.bucket_id
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}