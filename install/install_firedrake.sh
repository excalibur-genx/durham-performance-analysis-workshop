#!/bin/bash
module purge
module load python/3.6.5
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1

# Otherwise we pick up the gcc 7.3.0 libraries
unset LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/cosma/local/Python/3.6.5/lib

# Installer variables
export NEW_VENV_NAME=firedrake
export DATA=$HOME/data
export INSTALL_DIR=/tmp/$USER

# Create bin folder and link helper scripts
mkdir -p $DATA/bin
ln -s $PWD/firedrake_activate.sh $DATA/bin/
ln -s $PWD/update_firedrake_cache.sh $DATA/bin/
ln -s $PWD/update_firedrake_tarball.sh $DATA/bin/

mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

export PETSC_CONFIGURE_OPTIONS="--with-x=0 --with-make-np=8 \
    CC=$CC CXX=$CXX FC=$FC F77=$F77 F90=$F90 CPPFLAGS='$CPPFLAGS' \
    --COPTFLAGS='-O3 -march=native -mtune=native' \
    --CXXOPTFLAGS='-O3 -march=native -mtune=native' \
    --FOPTFLAGS='-O3 -march=native -mtune=native' \
    --LDFLAGS='$LDFLAGS'"

curl -O https://raw.githubusercontent.com/firedrakeproject/firedrake/master/scripts/firedrake-install

# Install firedrake with the following options
python3 firedrake-install \
    --no-package-manager \
    --remove-build-files \
    --pip-install $DATA/workspace/numpy/dist/numpy-1.19.5-cp36-cp36m-linux_x86_64.whl \
    --venv-name $NEW_VENV_NAME \
    --cache-dir $INSTALL_DIR/.cache_$NEW_VENV_NAME

mkdir -p $INSTALL_DIR/.cache_$NEW_VENV_NAME
touch $INSTALL_DIR/.cache_$NEW_VENV_NAME/foo

# Now tarball the venv so that it can be used on compute nodes
tar -czvf $DATA/bin/$NEW_VENV_NAME.tar.gz $NEW_VENV_NAME
tar -czvf $DATA/bin/cache_$NEW_VENV_NAME.tar.gz .cache_$NEW_VENV_NAME
