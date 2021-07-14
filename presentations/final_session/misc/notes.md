# Presentation notes

- What did you think before the course were the performance bottlenecks in your code, and was this confirmed through the tools?
- Which insights did you gain from which tools? 
- Which hurdles did you face? How did you overcome them (if you did)? Or why did you give up (if you did)?
- Did you achieve any measurable performance improvements throughout this course?
- What code improvements resulted from that/do you plan to do?
- What are your lessons learned?

## What is Firedrake?

Preface: it is important to know how Firedrake works and how it is different from most high-performance scientific libraries for the rest of the presentation to make sense.

Firstly, Firedrake solves PDEs with finite element method

## How does it work?

- The red blocks are the expensive ones.
- We only use MPI

## How is it different to most HPC codes?

- Firedrake is written in Python so it is interpreted with a script rather than compiled into a binary. 
  This introduces some challenges because a lot of performance tools work by using a compiler wrapper.

- Lots of the performance behaviour is handled by PETSc which is partially a 'black box' to Firedrake.
  Only high level configuration is really possible.

## Assumed performance characteristics

We know there are substantial latencies due to our use of Python. Part of my PhD is to reduce these by trying to cache as much of the code generation work as possible.

We are memory bound for both assembly and solving in the majority of cases. We are only compute bound at high order and when doing matrix-free calculations.

We believe that our MPI implementation is decent.
PETSc use something called a star forest model to handle their MPI communications and since they have put a lot of time and effort into introducing the object we assume that it is an effective tool.
For assembly we partition the mesh between processors and do some redundant computation along the borders.
We specially order our communications in order to reduce latencies.
A lot of effort has been put into designing this so we think it is probably sound.

## Aims for the workshop series

- Verify that our MPI implementation is sane (e.g. efficient and load-balanced) in both PyOP2 and PETSc
- Study performance characteristics of the generated assembly code (e.g. missed vectorisation opportunities, recommended transformations). Also want to see arithmetic intensity.

## MPI: Scaling

To start with, we ran some strong scaling experiments on DINE where we solved the Poisson equation in 3D using a multigrid method.
As you can see we achieved some decent scaling results but this was only possible by specifying a large number of options that get passed to PETSc.
This is significant to this series of workshops because it is not really suitable for us to use a low-level approach to optimising the solves since a higher-productivity approach is to specify options.
Despite this, the tools can still be useful in identifying the causes of hotspots (e.g. memory-bound) which could be useful in selecting some options.

## Hurdles

- Lots of the tools assume that you can simply add a compiler wrapper to your code when generating a binary. This simply doesn't work for us.
- MPI calls are made in Python so we can't just use a different compiler.
- Correctly installing Firedrake took several weeks. Need to tarball venv.
- Needed to compile our own Python and Score-P
- MUST and Score-P not compatible with PETSc (since fixed)
- Filtering profiling tools was essential since Python generates huge stack traces that we don't care about

## Success rate with the tools

*Show table of tool|did it work?|insights?* (Y/N)

Intel VTune | No | N/A  (just didn't work)
Allinea DDT | Yes | Yes
Score-P/Scalasca | Yes | Yes
Vampir | Yes | No  (did not give us anything useful)
MUST | Partial | N/A (works for PETSc and Firedrake import but broke when I tried to run the test case and did not have time to debug)
MAQAO | No | N/A  (static analysis of kernels gave some weird results, arithmetic intensity)
TODO Likwid

## Insights: Allinea DDT

- Allinea DDT gave us some useful results: we are memory bound and appear to have acceptable efficiency.
- Note that there are very few vector calculations - vectorisation hasn't been added to `master` yet.

## Insights: Score-P

Score-P is great because it has Python bindings.

Unfortunately we needed to compile our own Score-P as the one on the cluster did not work with PETSc.

- Score-P told us that we have apparently good load balancing. Also useful to see a timed breakdown of parts of the code. Python extension was nice.
- Could probably have extracted more information with more examples and more time.

## Takeaways

- Performance assumptions (sensible MPI and memory-bound) were somewhat verified
- No performance improvements attained over course
- We don't currently vectorise, that needs merging
- Performance can depend on PETSc configuration
- Score-P is a great tool - we should use it more.
- Lots of experience!


## Final slide

- Thanks to organisers!
- Any questions?
