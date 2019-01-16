

ROUTER_NAME=ser140-router1

docker stop $ROUTER_NAME
docker rm $ROUTER_NAME
docker run --name $ROUTER_NAME --net host                               \
    -e "FFR_NAME=$ROUTER_NAME"                                          \
    -e "LD_LIBRARY_PATH=/usr/lib/:/usr/local/lib/:/usr/lib64/"          \
    -v /sys/class/:/sys/class/ -v /freeflow:/freeflow -v /dev/:/dev/    \
    --privileged -it -d ffrouter bash
docker exec $ROUTER_NAME bash -c "cd /freeflow && bash build-router.sh"
docker exec $ROUTER_NAME /etc/init.d/openibd start
docker exec $ROUTER_NAME /etc/init.d/opensmd start
docker exec -d $ROUTER_NAME /freeflow/ffrouter/router $ROUTER_NAME
