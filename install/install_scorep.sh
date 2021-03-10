#!/bin/bash
module purge
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1
module load openmpi/4.0.5
module load ucx/1.8.1

# Installer variables
export DATA=/cosma5/data/do008/dc-bett2/
export SRC_DIR=$PWD
export INSTALL_DIR=/tmp/firedrake

export MPICC=$MPIROOT/bin/mpicc
export MPICXX=$MPIROOT/bin/mpicxx
export MPIF90=$MPIROOT/bin/mpifort
export MPIEXEC=$MPIROOT/bin/mpiexec


cd $INSTALL_DIR
TARGET=sources.1c2c67dd
wget http://perftools.pages.jsc.fz-juelich.de/cicd/scorep/branches/master/$TARGET.tar.gz
tar -xzf $TARGET.tar.gz
mv $TARGET scorep

mkdir scorep_build
cd scorep
SP_LDFLAGS="$LDFLAGS -Wl,-rpath=$INSTALL_DIR/scorep_build/lib -L$INSTALL_DIR/scorep_build/lib"
./configure --prefix=$INSTALL_DIR/scorep_build \
    --enable-shared \
    LDFLAGS="$SP_LDFLAGS"
make -j32
make -j32 install

cd ..
# Tarball everything
tar -czvf $DATA/bin/scorep.tar.gz scorep_build
