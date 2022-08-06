#! /bin/bash

set -e

source $HOME/mambaforge/etc/profile.d/conda.sh
source $HOME/mambaforge/etc/profile.d/mamba.sh

echo "Creating fresh daisy-dev virtual environment"
/usr/bin/time mamba env create --force --file $DAISY_DEV_SCRIPTS/daisy-dev.yml

echo "Activating daisy-dev"
mamba activate daisy-dev

echo "Cleanup"
mamba list
mamba clean --tarballs --yes

echo "Finished"
