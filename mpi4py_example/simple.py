from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.rank
size = comm.size

print('Rank:', rank, 'Size:', size)
