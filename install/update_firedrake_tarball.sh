#!/bin/bash

# INSTALL_DIR should be /tmp/firedrake
cd $INSTALL_DIR
mv $DATA/bin/$VENV_NAME.tar.gz $DATA/bin/$VENV_NAME.tar.gz.bck
tar -czvf $DATA/bin/$VENV_NAME.tar.gz $VENV_NAME
