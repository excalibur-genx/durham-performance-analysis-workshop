#!/bin/bash

# INSTALL_DIR and DATA should be set in firedrake activation script
cd $INSTALL_DIR
mv $DATA/bin/$VENV_NAME.tar.gz $DATA/bin/$VENV_NAME.tar.gz.bck
tar -czvf $DATA/bin/$VENV_NAME.tar.gz $VENV_NAME
