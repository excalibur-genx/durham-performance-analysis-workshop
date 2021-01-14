#!/bin/bash

# LOAD MODULES

export VENV_NAME=firedrake  # Or whatever you named the venv
export DATA=$HOME/data
export INSTALL_DIR=/tmp/firedrake

export MPICC=`which mpicc`
export MPICXX=`which mpicxx`
export MPIF90=`which mpif90`

# Set main to be working directory
# Create this in /tmp so we don't have issues with the lustre filesystem
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Set the PyOP2 compiler to ???
#export PYOP2_BACKEND_COMPILER=cc

tar -xzf $DATA/bin/$VENV_NAME.tar.gz -C $INSTALL_DIR

source $INSTALL_DIR/$VENV_NAME/bin/activate
