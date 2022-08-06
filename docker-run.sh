#! /bin/bash

set -e

echo "Removing 'daisy-dev' container"
echo "Ignore 'No such container' errors"
docker rm daisy-dev || true

echo "Running znmeb/daisy-dev"
docker run --interactive --tty \
  --name daisy-dev \
  --network host \
  znmeb/daisy-dev /bin/bash
