
DISABLE_FASTPATH=1
NR_ITERS=1000000

SRV_DOCKER_CMD="DISABLE_FASTPATH=$DISABLE_FASTPATH ib_send_lat -n $NR_ITERS"
CLT_DOCKER_CMD="DISABLE_FASTPATH=$DISABLE_FASTPATH ib_send_lat -n $NR_ITERS -U 10.44.0.0"

ssh root@r1 "screen -d -m docker exec -it node1 bash -c '$SRV_DOCKER_CMD'" && 
    docker exec -it node1 bash -c "$CLT_DOCKER_CMD"
