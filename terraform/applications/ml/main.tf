module "ecr" {
    source = "../../modules/ecr_default"
    aws_ecr_repos_name = "ecr_ml"
}

module "cloud_watch" {
    source = "../../modules/cw"
    aws_cloud_watch_name = var.aws_cloud_watch_name
}

resource "null_resource" "deploy_in_ecs" {
  provisioner "local-exec" {
    command = "bash ./applications/app/script.sh"
    environment = {
      AWS_REGION      = var.aws_region
      AWS_ACCOUNT_ID  = var.aws_account_id
      REPO_NAME       = "ecr_ml"
      IMAGE_NAME      = "projet_annuel_5_alpha_app"
      DOCKERFILE_PATH = "Dockerfile"
    }
  }
  depends_on = [
    module.ecr
  ]
}

module "ecs" {
    source = "../../modules/ecs"

    AWS_REGION              = var.aws_region

    AWS_ECR_REPOSITORY_URL  = module.ecr.aws_ecr_repository_url

    aws_ecs_cluster_name    = "ecs_cluster_ml"
    aws_ecs_container_name  = "ecs_container_ml"
    aws_ecs_port            = var.ecs_port
    aws_ecs_family_task     = "ecs_task_ml"
    aws_ecs_cpu             = var.ecs_cpu
    aws_ecs_memory          = var.ecs_memory
    aws_ecs_network_mode    = var.ecs_network_mode
    aws_ecs_role            = var.ecs_role

    aws_cloud_watch_name    = var.cloud_watch_name

    aws_ecs_env_list = [
      {
        name  = "AWS_ACCESS_KEY"
        value = var.aws_access_key
      },
      {
        name  = "AWS_SECRET_KEY"
        value = var.aws_secret_key
      },
      {
        name  = "AWS_ACCOUNT_ID"
        value = var.aws_account_id
      },
      {
        name  = "AWS_REGION"
        value = var.aws_region
      },
      {
        name  = "AWS_SQS_INPUT_QUEUE"
        value = var.sqs_input_queue
      },
      {
        name  = "AWS_SQS_OUTPUT_QUEUE"
        value = var.sqs_output_name
      },
      {
        name  = "AWS_BUCKET_NAME"
        value = var.bucket_name
      }
    ]
    depends_on = [
      module.ecr,
      module.cloud_watch,
      null_resource.deploy_in_ecs
    ]
}

module "ecs_service" {
  source = "../../modules/ecs/services/s"

  aws_ecs_service_name    = "ecs_service_app"
  aws_cluster_id          = module.ecs.aws_cluster_id
  aws_task_arn            = module.ecs.aws_task_arn
  security_group_id       = module.security_groups_app.security_group_id
  subnets                 = [var.SUBNET_PUBLIC_ID]

  depends_on = [
      module.security_groups_app,
      module.ecs
    ]
}