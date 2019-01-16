
for e in $(seq 1 23); do
    msg_size=$((2**$e))

    echo -e "\n\nmsg_size=$msg_size"
    ssh root@r0 "cd /freeflow/benchmarks && bash r0_iperf_s.sh"
    ssh root@r1 "cd /freeflow/benchmarks && bash r1_iperf_c.sh $msg_size"
done

# Do post-cleaning
ssh root@r0 "pkill -SIGKILL iperf3"
ssh root@r1 "pkill -SIGKILL iperf3"
