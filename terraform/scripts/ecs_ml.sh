#!/bin/bash
cd ../battle-card

#Création de l'image Docker
docker build --platform=linux/amd64 -t $IMAGE_NAME -f $DOCKERFILE_PATH .

#Connexion à ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

#Tag de l'image Docker
docker tag $IMAGE_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:latest

#Envoi de l'image Docker vers ECR
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:latest