#!/bin/bash

# Script para actualizar todas las imagenes de docker
# (C)horeo por Goro2030

ERROR_FILE="/tmp/docker-images-update.error"

# make sure that docker is running
DOCKER_INFO_OUTPUT=$(docker info 2> /dev/null | grep "Containers:" | awk '{print $1}')

if [ "$DOCKER_INFO_OUTPUT" == "Containers:" ]
  then
    echo "Docker is running, so we can continue"
  else
    echo "Docker is not running, exiting"
    exit 1
fi

# get a list of docker images that are currently installed
IMAGES_WITH_TAGS=$(docker images | grep -v REPOSITORY | grep -v TAG | grep -v "<none>" | awk '{printf("%s:%s\n", $1, $2)}')

# run docker pull on all of the images
for IMAGE in $IMAGES_WITH_TAGS; do
  echo "*****"
  echo "Updating $IMAGE"
  docker pull $IMAGE 2> $ERROR_FILE
  if [ $? != 0 ]; then
    ERROR=$(cat $ERROR_FILE | grep "not found")
    if [ "$ERROR" != "" ]; then
      echo "WARNING: Docker image $IMAGE not found in repository, skipping"
    else
      echo "ERROR: docker pull failed on image - $IMAGE"
#      exit 2
    fi
  fi
  echo "*****"
  echo
done

# did everything finish correctly? Then we can exit
echo "Docker images are now up to date"

docker compose up -d

docker system prune

exit 0

