
NODE_NAME=mb-server
ROUTER_NAME=ser140-router1

. ffnodes_conf.sh

docker stop $NODE_NAME
docker rm $NODE_NAME
docker run --name $NODE_NAME --net weave --ip ${guest_ip[$NODE_NAME]}  \
    -e "FFR_NAME=$ROUTER_NAME" -e "FFR_ID=${ffr_id[$NODE_NAME]}" -e "LD_LIBRARY_PATH=/usr/lib" \
    -v /sys/class/:/sys/class/ -v /freeflow:/freeflow -v /dev/:/dev/ \
    --ipc=container:$ROUTER_NAME \
    --privileged \
    --device=/dev/infiniband/uverbs0 --device=/dev/infiniband/rdma_cm \
    -it -d ffnode bash
docker exec $NODE_NAME bash -c "cd /freeflow && bash build-client.sh"
