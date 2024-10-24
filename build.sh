#!/bin/bash

set -x

DOCKERHUB_USER=manoharms
DOCKER_DEV_REPO=${DOCKERHUB_USER}/reactapp-dev
DOCKER_PROD_REPO=${DOCKERHUB_USER}/reactapp-prod
BRANCH_NAME=$1
echo $BRANCH_NAME
BRANCH_NAME=${BRANCH_NAME#origin/}

 #echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin

if [ "$BRANCH_NAME" == "dev" ]; then
    IMAGE_TAG="dev-latest"
    IMAGE_NAME=$DOCKER_DEV_REPO:$IMAGE_TAG
elif [ "$BRANCH_NAME" == "main" ]; then
    IMAGE_TAG="prod-latest"
    IMAGE_NAME=$DOCKER_PROD_REPO:$IMAGE_TAG
else
    echo "Unsupported branch: $BRANCH_NAME"
    exit 1
fi

docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME

