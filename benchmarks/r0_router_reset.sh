
docker exec router1 pkill -SIGKILL router
docker exec router1 rm -f /dev/shm/*
#docker exec router1 /etc/init.d/opensmd stop
#
#docker exec router1 /etc/init.d/openibd restart
#docker exec router1 /etc/init.d/opensmd start
#
#docker exec router1 ip addr add 192.168.10.140/24 dev ib0
#docker exec router1 ip link set ib0 up
#docker exec router1 ip addr show ib0

docker exec -d router1 /freeflow/ffrouter/router router1

