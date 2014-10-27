#!/bin/sh

docker run -t -i -p 8088:8088 -p 5002:5002/udp -p 5004:5004/udp \
       mskrajnowski/janus:latest /sbin/my_init -- \
       bash -l
