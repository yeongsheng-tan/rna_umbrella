#!/bin/bash
set -xe

APP_NAME=$1
VERSION=$2
BUILD_IMAGE=$3
REL_IMAGE=$4
TMP_REL_CONTAINER_NAME="tmp_rel_docker-`uuidgen`"

echo "APP_NAME: ${APP_NAME}"
echo "VERSION: ${VERSION}"
echo "BUILD_IMAGE: ${BUILD_IMAGE}"
echo "TEMP RELEASE CONTAINER NAME: ${TMP_REL_CONT_NAME}"

# docker rm -f ${TMP_REL_CONTAINER_NAME}

docker create --name ${TMP_REL_CONTAINER_NAME} ${BUILD_IMAGE}

rm -f ${APP_NAME}.tar.gz

docker cp ${TMP_REL_CONTAINER_NAME}:/opt/app/_build/prod/rel/${APP_NAME}/releases/${VERSION}/${APP_NAME}.tar.gz ${APP_NAME}.tar.gz

docker rm -f ${TMP_REL_CONTAINER_NAME}

docker build -f ./Dockerfile.release.${APP_NAME} -t ${REL_IMAGE} .

if [ $? == 0 ]; then
  echo "Docker image ${REL_IMAGE} has been successfully created."
  echo "You may startup and run your app with the commad:"
  echo "\t docker run -d -it --rm ${REL_IMAGE}"
fi
