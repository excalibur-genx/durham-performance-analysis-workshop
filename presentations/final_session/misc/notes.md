# Presentation notes

## Title slide

"I am going to be talking about Firedrake and what the team's experience of the workshops was like."

"Before discussing the tools it is quite important that I explain how Firedrake works and how it is different from most of the other codes that have come to the workshops."

## What is Firedrake?

### Flowchart

"The way users interact with Firedrake is as follows: first they write a Python script containing their PDE written in a near-mathematical form..."

- The red blocks are where most of the time is spent.
- Either can be a bottleneck depending on the code.

### Final remarks

- It is written in Python rather than C/C++/Fortran. We generate our C code instead.
- It only uses MPI for parallelism.

## Assumed performance characteristics

### Memory bound

- We are only compute bound at high order and when doing matrix-free calculations.

## Aims for the workshop series

## Hurdles to using the profiling tools

### Things not working

- Some examples:
  - Needed to compile our own Python and Score-P
  - MUST and Score-P were not compatible with PETSc. These bugs have since been fixed.

### C/C++/Fortran

- We were able to instrument the generated code with the correct compilers but a lot of the interesting behaviour happens in Python so this wasn't particularly useful.

## What did/didn't work?

"As you can see we had little to no success with many of the tools due to the sorts of problems I was just describing. I won't dwell on these and instead lets focus on the ones that generated useful insights."

### Allinea DDT

- Information was at a very high level.
- Told us that we are memory bound (for the problem at hand) and MPI efficiency seems good.

### Vampir

- We got some simple traces from it and managed to see the communication patterns but we found it quite difficult to use.

## Score-P

## Likwid

### Describing the roofline plot

- We were able to generate it from nothing in a matter of hours.
- Shows that we are vectorising nicely and that we have really good floating point throughput. 
- The top of the grey region shows peak FLOPS for AVX-512 and the bottom shows peak scalar throughput.
- We are not memory bound here because we are doing matrix-free assembly.

## Takeaways

### Initial performance assumptions verified

- Performance is actually really pretty good

## Final slide
