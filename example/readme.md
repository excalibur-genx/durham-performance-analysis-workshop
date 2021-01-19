# Example code

Solves a 3D Poisson problem using a variety of solver options.

Built in help:

```
poisson_gmg.py [-h] [--baseN BASEN] [--nref NREF] [--degree DEGREE]
                      [--resultsdir RESULTSDIR]
                      [--solver_params {LU,LU MUMPS,LU SuperLU_dist,MG V-cycle,MG F-cycle,MG F-cycle matfree,MG F-cycle LU coarse MUMPS,MG F-cycle LU coarse SuperLU_dist,MG F-cycle Cholesky coarse MUMPS,MG F-cycle Cholesky coarse SuperLU_dist,MG F-cycle PatchPC,MG F-cycle PatchPC telescope,MG F-cycle PatchPC telescope SuperLU_dist,MG F-cycle ASMStarPC,MG F-cycle ASMStarPC TinyASM}]
                      [--telescope_factor TELESCOPE_FACTOR]

optional arguments:
  -h, --help            show this help message and exit
  --baseN BASEN         base mesh size
  --nref NREF           number of mesh refinements
  --degree DEGREE       degree of CG element
  --resultsdir RESULTSDIR
                        directory to save results in
  --solver_params {LU,LU MUMPS,LU SuperLU_dist,MG V-cycle,MG F-cycle,MG F-cycle matfree,MG F-cycle LU coarse MUMPS,MG F-cycle LU coarse SuperLU_dist,MG F-cycle Cholesky coarse MUMPS,MG F-cycle Cholesky coarse SuperLU_dist,MG F-cycle PatchPC,MG F-cycle PatchPC telescope,MG F-cycle PatchPC telescope SuperLU_dist,MG F-cycle ASMStarPC,MG F-cycle ASMStarPC TinyASM}
                        name of dict to take solver parameters from
  --telescope_factor TELESCOPE_FACTOR
                        Telescope factor for telescoping solvers (set to number of NODES)
```

`baseN` corresponds to the size of the coarsest grid in the multigrid solver and `nref` corresponds to the number of multigrid levels minus 1.

Example usage:

```bash
mpiexec -n 8 python poisson_gmg.py \
    --resultsdir results/poisson_patch \
    --baseN 12 \
    --nref 3 \
    --solver_params "MG F-cycle PatchPC" \
    --telescope_factor 1
```

## Different solvers:

Direct solvers:
- **LU**: Direct solver using PETSc built in LU factorisation.
- **LU MUMPS**: Direct solver using MUMPS LU factorisation.
- **LU SuperLU_dist**: Direct solver using SuperLU_dist LU factorisation.


(Geometric) Multigrid solvers:
- **MG V-cycle**: A conjugate gradient (CG) Krylov Subspace solver (KSP) with multigrid (MG) V-cycle preconditioner (PC).
- **MG F-cycle**: Full MG preconditioner (no KSP).
- **MG F-cycle matfree**: Full MG PC using `firedrake.AssembledPC` and telescoping (and SuperLU_dist LU factorisation on coarsest grid).
- **MG F-cycle LU coarse MUMPS**: Full MG PC with direct solver using MUMPS LU factorisation on coarsest grid.
- **MG F-cycle LU coarse SuperLU_dist**: Full MG PC with direct solver using SuperLU_dist LU factorisation on coarsest grid.
- **MG F-cycle Cholesky coarse MUMPS**: Full MG PC with direct solver using MUMPS Cholesky factorisation on coarsest grid.
- **MG F-cycle Cholesky coarse SuperLU_dist**: Full MG PC with direct solver using MUMPS Cholesky factorisation on coarsest grid.


(Geometric) Multigrid with PatchPC:
- **MG F-cycle PatchPC**: Full MG PC using `firedrake.PatchPC` to apply star smoothing (and MUMPS LU factorisation on coarsest grid).
- **MG F-cycle PatchPC telescope**: Full MG PC using `firedrake.PatchPC` to apply star smoothing, with telescoping (and MUMPS LU factorisation on coarsest grid).
- **MG F-cycle PatchPC telescope SuperLU_dist**: Full MG PC using `firedrake.PatchPC` to apply star smoothing, with telescoping and SuperLU_dist LU factorisation on coarsest grid.
- **MG F-cycle ASMStarPC**: Full MG PC using `firedrake.ASMStarPC` to apply star smoothing (and MUMPS LU factorisation on coarsest grid).
- **MG F-cycle ASMStarPC TinyASM**: Full MG PC using `firedrake.ASMStarPC` and the TinyASM backend to apply star smoothing (and MUMPS LU factorisation on coarsest grid).
