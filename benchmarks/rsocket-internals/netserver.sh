#!/bin/bash

LD_PRELOAD=/usr/lib/rsocket/librspreload.so netserver -D -f -L 192.168.10.141 -4
