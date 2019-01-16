#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

FILES = ('mb_rsocket_np_lat.log.csv', 'mb_rsocket_np_lat_base.log.csv',
         'mb_rsocket_np_lat_lowcpu.log.csv')
LABELS = ('FF_rsocket', 'HOST_rsocket', 'FF_lowCPU_rsocket')


def extract_XY(fpath):
    lines = open(fpath).readlines()
    X = [float(line.split(',')[0]) for line in lines]
    Y = [float(line.split(',')[1]) for line in lines]
    return X, Y


for i, f in enumerate(FILES):
    X, Y = extract_XY(f)
    plt.plot(X, Y, label=LABELS[i])
#plt.xscale('log', basex=2)
plt.legend()
plt.xlabel('bytes')
plt.ylabel('latency (us)')
plt.show()
