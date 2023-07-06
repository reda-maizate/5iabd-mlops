resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = true

}

resource "aws_s3_bucket_public_access_block" "s3_policy" {
  bucket              = aws_s3_bucket.s3_bucket.id
  block_public_acls   = false
  block_public_policy = false
}