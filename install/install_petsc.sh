#!/bin/bash
module purge
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1
module load openmpi/4.0.5
module load ucx/1.8.1

# Set the PETSC_ARCH variable
export PETSC_ARCH=debug  # { default, debug, scorep }

# Installer variables
export SRC_DIR=$PWD
export INSTALL_DIR=/tmp/firedrake

export MPICC=$MPIROOT/bin/mpicc
export MPICXX=$MPIROOT/bin/mpicxx
export MPIF90=$MPIROOT/bin/mpifort
export MPIEXEC=$MPIROOT/bin/mpiexec

export PETSC_OPTS="\
  --with-cc=$MPICC \
  --with-cxx=$MPICXX \
  --with-fc=$MPIF90 \
  --with-mpiexec=$MPIEXEC \
  --with-x=0 
  --with-make-np=8 \
  --download-eigen=$INSTALL_DIR/eigen-3.3.3.tgz \
  --download-pnetcdf \
  --download-suitesparse \
  --with-c2html=0 \
  --download-superlu_dist \
  --download-metis \
  --download-ptscotch \
  --with-zlib \
  --with-fortran-bindings=0 \
  --with-shared-libraries=1 \
  --download-chaco \
  --download-hypre \
  --download-netcdf \
  --download-ml \
  --download-scalapack \
  --with-cxx-dialect=C++11 \
  --download-hdf5 \
  --download-mumps"

if [ "$PETSC_ARCH" = "default" ]; then
  export PETSC_OPTS="$PETSC_OPTS \
    --COPTFLAGS='-O3 -march=native -mtune=native' \
    --CXXOPTFLAGS='-O3 -march=native -mtune=native' \
    --FOPTFLAGS='-O3 -march=native -mtune=native' \
    --with-debugging=0"
fi

# Change directory
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Install Eigen
if [ ! -f "eigen-3.3.3.tgz" ]; then
  wget https://github.com/eigenteam/eigen-git-mirror/archive/3.3.3.tar.gz
  mv 3.3.3.tar.gz eigen-3.3.3.tgz
fi

# Clone PETSc if needed
if [ ! -d "petsc" ]; then
  git clone -b release https://gitlab.com/petsc/petsc.git petsc
fi

# Do installation
cd petsc
./configure $PETSC_OPTS
make all
make check

