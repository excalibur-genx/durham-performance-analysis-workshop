#!/bin/bash

# LOAD MODULES
module purge
module load python/3.6.5
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1

unset LD_LIBRARY_PATH

export VENV_NAME=firedrake  # Or whatever you named the venv
#export DATA=$HOME/data
export DATA=/cosma5/data/do008/dc-bett2
export INSTALL_DIR=/tmp/firedrake

# Set main to be working directory
# Create this in /tmp so we don't have issues with the lustre filesystem
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Set the PyOP2 compiler to ???
# export PYOP2_BACKEND_COMPILER=$VIRTUAL_ENV/bin/mpicc

tar -xzf $DATA/bin/$VENV_NAME.tar.gz -C $INSTALL_DIR

source $INSTALL_DIR/$VENV_NAME/bin/activate

# Return to original directory
cd -
