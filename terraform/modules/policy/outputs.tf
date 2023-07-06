output "lambda_iam_json_policy" {
  value = data.aws_iam_policy_document.policy_lambda_iam.json
}