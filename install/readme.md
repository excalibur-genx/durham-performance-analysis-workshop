# Installing Firedrake on DINE

This assumes you have already cloned this repository to the DINE system.

You should use the data partition and not you're home directory for all code.


## Prerequisites

You need to build a wheel for numpy as the COSMA system adds the numpy library to various paths that prevent the firedrake install script from running.

You may want to rename the virtual environment by changing the `NEW_VENV_NAME` environment variable in the install script.

Make sure the `DATA` environment variable in the install script points to the data partition.


## Installing

Should be as simple as:

```bash
./install_firedrake.sh
```

## Postrequisites

You need to edit the variables `VENV_NAME`, `DATA` and `INSTALL_DIR` in `firedrake_activate.sh`.
These paths should be explicit (no Bash vairables) and absolute (not relative) paths.

You probably want to add the explicit path `$DATA/bin` to your `PATH` environment variable too.
