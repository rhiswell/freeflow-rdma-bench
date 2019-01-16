#!/usr/local/env python3

import matplotlib.pyplot as plt

FILES = ('mb_rsocket_iperf_tput.log.csv', 'mb_rsocket_iperf_tput_base.log.csv',
         'mb_rsocket_iperf_tput_lowcpu.log.csv')
LABELS = ('FF', 'HOST', 'FF_lowCPU')


def extract_XY(fpath):
    lines = open(fpath).readlines()
    X = [float(line.split(',')[0]) for line in lines]
    Y = [float(line.split(',')[1]) for line in lines]
    return X, Y


for i, f in enumerate(FILES):
    X, Y = extract_XY(f)
    plt.plot(X, Y, label=LABELS[i])
plt.xscale('log', basex=2)
plt.legend()
plt.xlabel('bytes')
plt.ylabel('tput (Gb/sec)')
plt.show()
