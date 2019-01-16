
pkill -SIGKILL iperf3
DISABLE_FASTPATH=1 LD_PRELOAD=/usr/lib/rsocket/librspreload.so iperf3 -i 0 -s
