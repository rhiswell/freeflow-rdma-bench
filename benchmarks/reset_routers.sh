
for t in r0 r1; do 
    ssh root@$t "cd /freeflow/benchmarks && bash ${t}_router_reset.sh"
done
