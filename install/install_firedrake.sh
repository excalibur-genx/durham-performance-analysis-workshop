#!/bin/bash
module purge
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1
module load openmpi/4.0.5
module load ucx/1.8.1

# Installer variables
export SRC_DIR=$PWD
export NEW_VENV_NAME=firedrake
export DATA=/cosma5/data/do008/dc-bett2/
export INSTALL_DIR=/tmp/firedrake

# Create bin folder and link helper scripts
mkdir -p $DATA/bin
ln -s $SRC_DIR/firedrake_activate.sh $DATA/bin/
ln -s $SRC_DIR/update_firedrake_cache.sh $DATA/bin/
ln -s $SRC_DIR/update_firedrake_tarball.sh $DATA/bin/

mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

export MPICC=$MPIROOT/bin/mpicc
export MPICXX=$MPIROOT/bin/mpicxx
export MPIF90=$MPIROOT/bin/mpifort
export MPIEXEC=$MPIROOT/bin/mpiexec

# We're going to build our own Python (inside this tarball)
tar -xzf $DATA/bin/py38.tar.gz

export PETSC_CONFIGURE_OPTIONS="--with-x=0 --with-make-np=8 \
    --COPTFLAGS='-O3 -march=native -mtune=native' \
    --CXXOPTFLAGS='-O3 -march=native -mtune=native' \
    --FOPTFLAGS='-O3 -march=native -mtune=native'"

curl -O https://raw.githubusercontent.com/firedrakeproject/firedrake/master/scripts/firedrake-install
patch firedrake-install $SRC_DIR/no_pastix.patch

# Install firedrake with the following options
/tmp/firedrake/py38/bin/python3 firedrake-install \
    --mpicc $MPICC \
    --mpicxx $MPICXX \
    --mpif90 $MPIF90 \
    --mpiexec $MPIEXEC \
    --no-package-manager \
    --remove-build-files \
    --venv-name $NEW_VENV_NAME \
    --cache-dir $INSTALL_DIR/.cache_$NEW_VENV_NAME

mkdir -p $INSTALL_DIR/.cache_$NEW_VENV_NAME
touch $INSTALL_DIR/.cache_$NEW_VENV_NAME/foo

# Now tarball the venv so that it can be used on compute nodes
tar -czvf $DATA/bin/$NEW_VENV_NAME.tar.gz $NEW_VENV_NAME
tar -czvf $DATA/bin/cache_$NEW_VENV_NAME.tar.gz .cache_$NEW_VENV_NAME
