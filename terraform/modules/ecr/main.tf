resource aws_ecr_repository ecr_repo {
  name         = var.ecr_repository_name
  force_delete = true
}

resource null_resource ecr_image {
  depends_on = [aws_ecr_repository.ecr_repo]
  triggers   = {
    python_file = md5(file("${path.cwd}/scripts/ingest/main.py"))
    docker_file = md5(file("${path.cwd}/scripts/ingest/Dockerfile"))
  }
  provisioner "local-exec" {
    command = <<EOF
           docker logout public.ecr.aws
           docker logout ${var.aws_caller_identity_current_account_id}.dkr.ecr.${var.region}.amazonaws.com
           docker login --username ${var.aws_ecr_authorization_token_token_user_name} --password ${var.aws_ecr_authorization_token_token_password} ${var.aws_caller_identity_current_account_id}.dkr.ecr.${var.region}.amazonaws.com
           cd ${path.cwd}/scripts/ingest/
           docker buildx build --platform linux/amd64 --provenance=false -t ${aws_ecr_repository.ecr_repo.repository_url}:${var.ecr_image_tag} . --push
       EOF
  }
}

data aws_ecr_image ecr_lambda_image {
  depends_on = [
    null_resource.ecr_image
  ]
  repository_name = var.ecr_repository_name
  image_tag       = var.ecr_image_tag
}