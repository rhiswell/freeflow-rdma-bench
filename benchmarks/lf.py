#!/usr/local/env python3

import matplotlib.pyplot as plt

#FILES = ('host_ib_send_lat_U.log', 'ff_ib_send_lat_U.log')
#FILES = ('host_ib_send_lat_U.log', )
#FILES = ('ff_ib_send_lat_U.log', )
FILES = ('ff_lowCPU_ib_send_lat_U1.log', )
#LABELS = ('HOST', 'FF')
#LABELS = ('FF', )
LABELS = ('FF_lowCPU', )


def extract_XY(fpath):
    lines = open(fpath).readlines()
    X = [float(line.split(',')[0]) for line in lines]
    Y = [float(line.split(',')[1]) for line in lines]
    return X, Y


for i, f in enumerate(FILES):
    X, Y = extract_XY(f)
    plt.plot(X, Y, label=LABELS[i])
plt.legend()
plt.ylabel('RTT/2 (us)')
plt.show()
