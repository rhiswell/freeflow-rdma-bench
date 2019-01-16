#!/usr/local/env python3

import matplotlib.pyplot as plt

FILES = ('mb_ib_send_bw.csv', 'mb_ib_write_bw.csv',
         'mb_ib_send_bw_base.log.csv', 'mb_ib_write_bw_base.log.csv',
         'mb_ib_send_bw_lowcpu.log.csv', 'mb_ib_write_bw_lowcpu.log.csv')
LABELS = ('FF_SEND', 'FF_WRITE', 'HOST_SEND', 'HOST_WRITE', 'FF_lowCPU_SEND',
          'FF_lowCPU_WRITE')


def extract_XY(fpath):
    lines = open(fpath).readlines()
    X = [float(line.split(',')[0]) for line in lines]
    Y = [float(line.split(',')[3]) for line in lines]
    return X, Y


for i, f in enumerate(FILES):
    X, Y = extract_XY(f)
    plt.plot(X, Y, label=LABELS[i])
plt.xscale('log', basex=2)
plt.legend()
plt.xlabel('bytes')
plt.ylabel('average BW (MB/sec)')
plt.show()
