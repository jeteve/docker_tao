#!/usr/bin/sh
set -xe

# Set this if you are on a network that does ssl inspection
# WGET_OPTS=--no-check-certificate

# Legacy version.
# TAO_VERSION=6.2.0
#  docker build \
#   --build-arg BUILD_IMAGE=ubuntu:precise-20150320 \
#   --build-arg LEGACY=1 \
#   --build-arg TAO_VERSION=$TAO_VERSION \
#   --build-arg WGET_OPTS=$WGET_OPTS \
#   -t jeteve/tao_ace:$TAO_VERSION .

# exit 0

TAO_VERSION=7.1.0
docker build \
  --build-arg BUILD_IMAGE=ubuntu:jammy \
  --build-arg TAO_VERSION=$TAO_VERSION \
  --build-arg WGET_OPTS=$WGET_OPTS \
  -t jeteve/tao_ace:$TAO_VERSION\
   .

TAO_VERSION=7.1.2
docker build \
  --build-arg BUILD_IMAGE=ubuntu:jammy \
  --build-arg TAO_VERSION=$TAO_VERSION \
  --build-arg WGET_OPTS=$WGET_OPTS \
  -t jeteve/tao_ace:$TAO_VERSION\
   .


# Latest release
TAO_VERSION=8.0.2
docker build \
  --build-arg BUILD_IMAGE=ubuntu:jammy \
  --build-arg TAO_VERSION=$TAO_VERSION \
  --build-arg WGET_OPTS=$WGET_OPTS \
  -t jeteve/tao_ace:$TAO_VERSION\
  -t jeteve/tao_ace:latest \
   .
