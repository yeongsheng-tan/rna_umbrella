#!/bin/bash
set -xe

APP_NAME=$1
VERSION=$2
BUILD_IMAGE=$3

rm -rf _build/dev

docker build -f ./Dockerfile.build.${APP_NAME} -t ${BUILD_IMAGE} .
