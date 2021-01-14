#!/bin/bash

# INSTALL_DIR should be /tmp/firedrake
cd $INSTALL_DIR
tar -czvf $DATA/bin/cache_$VENV_NAME.tar.gz cache_$VENV_NAME
