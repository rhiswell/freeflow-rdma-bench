
for e in $(seq 1 2); do
    msg_size=$((2**$e))

    echo -e "\n\nmsg_size=$msg_size"
    bash reset_routers.sh
    ssh root@r0 \
        "docker exec -d node1 bash /freeflow/benchmarks/r0n1_iperf_s.sh"
    ssh root@r1 \
        "docker exec node1 bash /freeflow/benchmarks/r1n1_iperf_c.sh $msg_size"
done
