
LD_PRELOAD=/usr/lib/rsocket/librspreload.so perf record -F 99 -a --call-graph dwarf -- netperf -4 -t TCP_RR -H 192.168.10.141 -- -r 1,1
