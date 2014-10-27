#!/bin/sh

apt-get install -y dh-autoreconf git libevent-dev libssl-dev

cd $HOME
git clone https://github.com/payden/libwebsock.git \
          --branch 'v1.0.4' --single-branch

cd libwebsock
    ./autogen.sh
    ./configure --prefix=/usr && make && make install
cd ..

rm -r libwebsock
