
mkdir -p /freeflow/benchmarks/output

docker exec node1 pkill ib_send_lat
docker exec node1 ib_send_lat -a

