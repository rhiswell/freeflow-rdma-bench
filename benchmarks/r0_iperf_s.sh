
pkill -SIGKILL iperf3
LD_PRELOAD=/usr/lib/rsocket/librspreload.so \
    iperf3 -s -D -i 0
