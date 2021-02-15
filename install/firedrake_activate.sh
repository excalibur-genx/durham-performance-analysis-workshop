#!/bin/bash

# LOAD MODULES
module purge
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1
module load openmpi/4.0.5
module load ucx/1.8.1

export VENV_NAME=firedrake              # Or whatever you named the venv
export DATA=/cosma5/data/do008/dc-bett2 # Path to data partition
export INSTALL_DIR=/tmp/firedrake       # Path to firedrake install

# Set main to be working directory
# Create this in /tmp so we don't have issues with the lustre filesystem
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Extract Firedrake and cache tarballs, make them world writable
tar -xzf $DATA/bin/py38.tar.gz
tar -xzf $DATA/bin/$VENV_NAME.tar.gz -C $INSTALL_DIR
tar -xzf $DATA/bin/cache_$VENV_NAME.tar.gz -C $INSTALL_DIR
chmod -R g+w *

source $INSTALL_DIR/$VENV_NAME/bin/activate

# Return to original directory
cd -
