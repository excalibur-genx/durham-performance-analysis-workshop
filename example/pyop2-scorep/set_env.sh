export DATA=/cosma5/data/durham/dc-ward1
export INSTALL_DIR=/tmp/firedrake
export VENV_NAME=firedrake-connor  # for some reason the old Firedrake install does not pick up the correct call stack

# Load modules
module purge
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1
module load openmpi/4.0.5
module load ucx/1.8.1

# These are set in the activate script but somehow not exported
export OMPI_MCA_btl_tcp_if_include=p1p2
export UCX_NET_DEVICES=mlx5_1:1

# 256MB
export SCOREP_TOTAL_MEMORY=262144000
export SCOREP_PROFILING_MAX_CALLPATH_DEPTH=65
export SCOREP_FILTERING_FILE=$PWD/scorep.filter
export SCOREP_EXPERIMENT_DIRECTORY="results"

export PYOP2_BACKEND_COMPILER="scorep-gcc"

source $INSTALL_DIR/$VENV_NAME/bin/activate

PATH=$PATH:$INSTALL_DIR/scorep_build/bin

# $CC and $CXX interfere with PYOP2
unset CC
unset CXX
export OMP_NUM_THREADS=1
