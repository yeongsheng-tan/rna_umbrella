#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $@" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $@" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $@" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $@" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

#/ Usage: build_pack_release.sh $RELEASE_VERSION
#/ Description:
#/ Examples: bash ./build_pack_release.sh
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

compile_build_image() {
  docker build -f docker/Dockerfile.build -t rna/rna_umbrella:build .
}

extract_release_tarball() {
  docker create --name rna_umbrella_tmp rna/rna_umbrella:build

  rm -f ./rna_umbrella.tar.gz

  docker cp rna_umbrella_tmp:/opt/app/_build/prod/rel/rna_umbrella/releases/0.3.0/rna_umbrella.tar.gz .

  docker rm -f rna_umbrella_tmp
}

build_release_image() {
  docker build -f docker/Dockerfile.release -t rna/rna_umbrella:release .
}

clean_images_without_tag() {
  docker images|grep \<none\>|awk '{print $3}' | xargs -r docker rmi
}

if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
    compile_build_image && \
    extract_release_tarball && \
    build_release_image
fi
