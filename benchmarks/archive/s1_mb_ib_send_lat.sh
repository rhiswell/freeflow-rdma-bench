
mkdir -p /freeflow/benchmarks/output

docker exec node1 pkill ib_send_lat
docker exec node1 sh -c 'ib_send_lat -a 10.40.0.0 > /freeflow/benchmarks/output/mb_ib_send_lat.log'
#docker exec node1 ib_send_lat -a 10.40.0.0
