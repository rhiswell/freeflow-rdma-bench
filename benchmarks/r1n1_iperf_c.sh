
#for e in $(seq 1 23); do
#    msg_size=$((2**$e))
#
##    printf "$msg_size," && \
##        LD_PRELOAD=/usr/lib/rsocket/librspreload.so \
##        iperf3 -i 0 -f g -c 10.40.0.0 -w $msg_size | grep sender | \
##        egrep -o "[0-9]+(\.[0-9]+)? [K|M|G]bits/sec"
#    printf "\n\n$msg_size\n" && \
#        LD_PRELOAD=/usr/lib/rsocket/librspreload.so \
#        iperf3 -i 0 -f g -c 10.40.0.0 -w $msg_size
#done

MSG_SIZE=$1

pkill -SIGKILL iperf3
DISABLE_FASTPATH=1 LD_PRELOAD=/usr/lib/rsocket/librspreload.so \
    iperf3 -J -i 0 -f g -c 10.40.0.0 -w $MSG_SIZE
