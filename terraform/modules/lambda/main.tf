resource "aws_iam_role" "lambda_iam_role" {
  name               = "${var.lambda_name}-lambda-iam-role"
  assume_role_policy = var.lambda_policy_json
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_iam_role.arn
  image_uri     = var.image_uri
  package_type  = "Image"
  memory_size   = var.memory_size
  timeout       = var.timeout

  environment {
    variables = {
      S3_BUCKET = var.s3_bucket_name
    }
  }
}


resource "aws_lambda_permission" "lambda-permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.s3_bucket_name}"
}