import time

from firedrake import *
from firedrake.assemble import create_assembly_callable


MESH_SIZE = 10
N_REPEATS = 1000


mesh = UnitSquareMesh(MESH_SIZE, MESH_SIZE)
V = FunctionSpace(mesh, "CG", 3)
v = TestFunction(V)
L = v * dx

PETSc.Sys.Print(f"Total DoF: {V.dim()}")

out = Function(V)
callable_ = create_assembly_callable(L, tensor=out)

start = time.time()
for _ in range(N_REPEATS):
    callable_()
end = time.time()

PETSc.Sys.Print(f"Time per assemble (us): {(end-start) / N_REPEATS * 1e6}")
