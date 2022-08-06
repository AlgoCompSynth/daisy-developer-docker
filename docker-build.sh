#! /bin/bash

set -e

echo "Pulling ubuntu:jammy"
docker pull ubuntu:jammy

echo "Building znmeb/daisy-dev"
/usr/bin/time docker build \
  --tag znmeb/daisy-dev:latest \
  . > /tmp/daisy-dev.log 2>&1
