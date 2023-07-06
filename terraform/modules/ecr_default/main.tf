resource "aws_ecr_repository" "ecr_default" {
  name = var.aws_ecr_repos_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "ecr_repos" {
  repository = aws_ecr_repository.ecr_default.name
  policy     = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid    = "AllowPull"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "ecr:*"
        ]
      }
    ]
  })
}