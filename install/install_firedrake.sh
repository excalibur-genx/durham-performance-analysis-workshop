#!/bin/bash
module purge
module load python/3.6.5
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1
module load openmpi/4.0.5

# Otherwise we pick up the gcc 7.3.0 libraries
unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/cosma/local/Python/3.6.5/lib

# Set data directory
export DATA=/cosma5/data/durham/$USER

# Installer variables
export VENV_NAME=firedrake
export INSTALL_DIR=/tmp/$USER
export CACHE_DIR=$INSTALL_DIR/.cache_$VENV_NAME
export NUMPY_WHEEL=$DATA/numpy-1.19.5-cp36-cp36m-linux_x86_64.whl
export PETSC_CONFIGURE_OPTIONS="--with-x=0 --with-make-np=8 \
    CC=$CC CXX=$CXX FC=$FC F77=$F77 F90=$F90 CPPFLAGS='$CPPFLAGS' \
    --COPTFLAGS='-O3 -march=native -mtune=native' \
    --CXXOPTFLAGS='-O3 -march=native -mtune=native' \
    --FOPTFLAGS='-O3 -march=native -mtune=native' \
    --LDFLAGS='$LDFLAGS'"

# Create bin folder and link helper scripts
mkdir -p $DATA/bin
ln -s $PWD/firedrake_activate.sh $DATA/bin/
ln -s $PWD/update_firedrake_cache.sh $DATA/bin/
ln -s $PWD/update_firedrake_tarball.sh $DATA/bin/

mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Rename the old virtualenv.
mv $VENV_NAME $VENV_NAME.old

curl -O https://raw.githubusercontent.com/firedrakeproject/firedrake/master/scripts/firedrake-install

# Install firedrake with the following options
python3 firedrake-install \
    --no-package-manager \
    --remove-build-files \
    --minimal-petsc \
    --pip-install $NUMPY_WHEEL \
    --venv-name $VENV_NAME \
    --cache-dir $CACHE_DIR \
    --mpicc mpicc \
    --mpicxx mpicxx \
    --mpif90 mpif90 \
    --mpiexec mpiexec

mkdir -p $CACHE_DIR
touch $CACHE_DIR/foo  # why do this?

# Now tarball the venv so that it can be used on compute nodes.
tar -czvf $DATA/$VENV_NAME.tar.gz $VENV_NAME
tar -czvf $DATA/cache_$VENV_NAME.tar.gz $CACHE_DIR
