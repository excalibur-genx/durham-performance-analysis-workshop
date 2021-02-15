#!/bin/bash
module purge
module load gnu_comp/10.2.0
module load cmake/3.18.1
module load bison/3.4.1
module load openmpi/4.0.5
module load ucx/1.8.1

# Installer variables
export DATA=$HOME/data
export TEMP_PATH=/tmp/firedrake
mkdir -p $DATA/bin
mkdir -p $TEMP_PATH
cd $TEMP_PATH

# LibFFI
git clone https://github.com/libffi/libffi.git
cd libffi
./autogen.sh
./configure --prefix=$TEMP_PATH/libffi/libffi --disable-docs
make -j32
make -j32 install
cd ..

# OpenSSL
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout -b OpenSSL_1_1_1 tags/OpenSSL_1_1_1
mkdir openssl

SSL_LDFLAGS="$LDFLAGS -Wl,-rpath=$TEMP_PATH/openssl/openssl/lib -L$TEMP_PATH/openssl/openssl/lib"
./config --prefix=$TEMP_PATH/openssl/openssl LDFLAGS="$SSL_LDFLAGS"
make -j32
make -j32 install
cd ..
rmdir /tmp/firedrake/openssl/openssl/ssl/certs/
ln -s /etc/pki/tls/certs /tmp/firedrake/openssl/openssl/ssl/certs
ln -s /etc/pki/tls/cert.pem /tmp/firedrake/openssl/openssl/ssl/

# Python
git clone https://github.com/python/cpython.git
mkdir py38
cd cpython
git checkout -b v3.8.7 tags/v3.8.7

PY_LDFLAGS="$LDFLAGS -Wl,-rpath=$TEMP_PATH/openssl/openssl/lib -L$TEMP_PATH/openssl/openssl/lib"
PY_LDFLAGS="$PY_LDFLAGS -Wl,-rpath=$TEMP_PATH/libffi/libffi/lib64 -L$TEMP_PATH/libffi/libffi/lib64"
PY_LDFLAGS="$PY_LDFLAGS -Wl,-rpath=$TEMP_PATH/py38/lib -L$TEMP_PATH/py38/lib"
PY_CFLAGS="-I$TEMP_PATH/openssl/openssl/include -I$TEMP_PATH/libffi/libffi/include"
PY_CPPFLAGS="-I$TEMP_PATH/openssl/openssl/include -I$TEMP_PATH/libffi/libffi/include"
./configure --prefix=$TEMP_PATH/py38 \
    --with-ensurepip --with-openssl=$TEMP_PATH/openssl \
    --enable-shared --enable-profiling --enable-optimizations \
    LDFLAGS="$PY_LDFLAGS" CFLAGS="$PY_CFLAGS" CPPFLAGS="$PY_CPPFLAGS"
make -j32
make -j32 install
cd ..

# Tarball everything
tar -czvf $DATA/bin/py38.tar.gz libffi openssl py38
