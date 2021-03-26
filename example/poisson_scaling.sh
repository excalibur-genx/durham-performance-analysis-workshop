#!/bin/bash

BATCH_NAME=poisson_telescope_x
SOLVER_PARAMS="MG F-cycle PatchPC telescope"
RESULTS_DIR=results/${BATCH_NAME}
mkdir -p ${RESULTS_DIR}

SPACING=1
for NODES in 1 2 4 8 #16
    do
    sbatch -N ${NODES} \
        -J ${BATCH_NAME} \
        -o ${RESULTS_DIR}/${NODES}_nodes.out \
        -e ${RESULTS_DIR}/${NODES}_nodes.err \
        --export=ALL,NODES=${NODES},SPACING=${SPACING},RESULTS_DIR=${RESULTS_DIR},SOLVER_PARAMS="${SOLVER_PARAMS}" \
        poisson.slm
done
