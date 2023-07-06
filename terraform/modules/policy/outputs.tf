output "lambda_iam_json_policy" {
  value = data.aws_iam_policy_document.policy_lambda_iam.json
}

output "eks_cluster_iam_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}