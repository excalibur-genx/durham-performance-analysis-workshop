module purge
module load gnu_comp/7.3.0
module load openmpi/3.0.1
module load python/3.6.5
module load vtune

export MPS_STAT_LEVEL=2

mpiexec --mca btl_tcp_if_include p1p2 -n 2 aps -r vtune --collection-mode=mpi python3 simple.py

# Output:
# python3: symbol lookup error: /cosma/local/intel/Parallel_Studio_XE_2019/vtune_amplifier_2019.4.0.597835/lib64/libmps.so: undefined symbol: PMPI_Initialized
# python3: symbol lookup error: /cosma/local/intel/Parallel_Studio_XE_2019/vtune_amplifier_2019.4.0.597835/lib64/libmps.so: undefined symbol: PMPI_Initialized
# aps Error: Cannot run: python3 simple.py
# aps Error: Cannot run: python3 simple.py
# -------------------------------------------------------
# Primary job  terminated normally, but 1 process returned
# a non-zero exit code. Per user-direction, the job has been aborted.
# -------------------------------------------------------
# --------------------------------------------------------------------------
# mpiexec detected that one or more processes exited with non-zero status, thus causing
# the job to be terminated. The first process to do so was:
#
#   Process name: [[51256,1],1]
#   Exit code:    2
# --------------------------------------------------------------------------
