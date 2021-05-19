#!/bin/bash

# INSTALL_DIR and DATA should be set in firedrake activation script
cd $INSTALL_DIR
tar -czvf $DATA/bin/cache_$VENV_NAME.tar.gz .cache_$VENV_NAME
