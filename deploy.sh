#!/bin/bash

set -x

BRANCH_NAME=$1
BRANCH_NAME="${BRANCH_NAME#origin/}"
DOCKER_DEV_REPO=manoharms/reactapp-dev:dev-latest
DOCKER_PROD_REPO=manoharms/reactapp-prod:prod-latest

if [ "$BRANCH_NAME" == "dev" ]; then
    DOCKER_IMAGE=$DOCKER_DEV_REPO
    NODE_ENV=development
elif [ "$BRANCH_NAME" == "main" ]; then
    DOCKER_IMAGE=$DOCKER_PROD_REPO
    NODE_ENV=production
else
    echo "Unsupported branch: $BRANCH_NAME"
    exit 1
fi

echo "DOCKER_IMAGE=$DOCKER_IMAGE" > .env
echo "NODE_ENV=$NODE_ENV" >> .env

docker-compose pull
docker-compose up -d

