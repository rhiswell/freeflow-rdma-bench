#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

FILES = ('mb_ib_send_lat.csv', 'mb_ib_write_lat.csv',
         'mb_ib_send_lat_base.log.csv', 'mb_ib_write_lat_base.log.csv',
         'mb_ib_send_lat_lowcpu.log.csv', 'mb_ib_write_lat_lowcpu.log.csv')
LABELS = ('FF_SEND', 'FF_WRITE', 'HOST_SEND', 'HOST_WRITE', 'FF_lowCPU_SEND',
          'FF_lowCPU_WRITE')


def extract_X(fpath):
    lines = open(fpath, 'r').readlines()
    return [float(line.split()[1].strip()) for line in lines]


XX = [extract_X(f) for f in FILES]
print(XX[0][0])

for i, X in enumerate(XX):
    Y = np.arange(len(X)) / float(len(X))
    plt.plot(X, Y, label=LABELS[i])
plt.legend()
plt.xlabel('latency (usec)')
plt.show()
