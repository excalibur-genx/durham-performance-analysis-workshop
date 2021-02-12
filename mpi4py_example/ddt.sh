module purge
module load gnu_comp/7.3.0
module load openmpi/3.0.1
module load python/3.6.5
module load allinea/ddt/20.2.1

perf-report mpiexec --mca btl_tcp_if_include p1p2 -n 2 python3 simple.py

# Output:
# --------------------------------------------------------------------------
# WARNING: No preset parameters were found for the device that Open MPI
# detected:
#
#   Local host:            b102
#   Device name:           mlx5_0
#   Device vendor ID:      0x02c9
#   Device vendor part ID: 41682
#
# Default device parameters will be used, which may result in lower
# performance.  You can edit any of the files specified by the
# btl_openib_device_param_files MCA parameter to set values for your
# device.
#
# NOTE: You can turn off this warning by setting the MCA parameter
#       btl_openib_warn_no_device_params_found to 0.
# --------------------------------------------------------------------------
# --------------------------------------------------------------------------
# No OpenFabrics connection schemes reported that they were able to be
# used on a specific port.  As such, the openib BTL (OpenFabrics
# support) will be disabled for this port.
#
#   Local host:           b102
#   Local device:         mlx5_1
#   Local port:           1
#   CPCs attempted:       rdmacm, udcm
# --------------------------------------------------------------------------
# ===================================================================
# The Allinea Sampler has limited support for MPI when thread support
# is set to MPI_THREAD_SERIALIZED or MPI_THREAD_MULTIPLE (as specified
# in the call to MPI_Init_thread).
# Only MPI communication on the main thread will appear in the MPI
# metrics graph. Time spent in MPI calls on non-main threads will be
# reported as MPI-time (vs compute-time) but the MPI calls from those
# threads will not contribute to the metric graphs.
# The fully supported arguments to MPI_Init_thread are MPI_THREAD_SINGLE
# (only one thread will execute) and MPI_THREAD_FUNNELED (if the
# process is multithreaded, only the main thread will make MPI
# calls).
# ===================================================================
# Rank: 0 Size: 2
# Rank: 1 Size: 2
# [b102.pri.cosma7.alces.network:36619] 3 more processes have sent help message help-mpi-btl-openib.txt / no device params found
# [b102.pri.cosma7.alces.network:36619] Set MCA parameter "orte_base_help_aggregate" to 0 to see all help / error messages
# [b102.pri.cosma7.alces.network:36619] 3 more processes have sent help message help-mpi-btl-openib-cpc-base.txt / no cpcs for port
