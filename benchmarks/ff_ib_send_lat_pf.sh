
FILE_TO_LOG=$(mktemp)

DISABLE_FASTPATH=0
NR_ITERS=10000000

SRV_DOCKER_CMD="DISABLE_FASTPATH=$DISABLE_FASTPATH ib_send_lat -n $NR_ITERS"
CLT_DOCKER_CMD="DISABLE_FASTPATH=$DISABLE_FASTPATH ib_send_lat -n $NR_ITERS -U 10.44.0.0" 

ssh root@r1 "screen -d -m docker exec -it node1 bash -c '$SRV_DOCKER_CMD'" && \
    docker exec -it node1 bash -c "$CLT_DOCKER_CMD" > $FILE_TO_LOG
    
cat $FILE_TO_LOG | egrep "^[0-9]" | awk -F',' '{ if ($2 > 60) print $1 $2 }'
cat $FILE_TO_LOG | grep -A1 "page reclaims"

rm -rf $FILE_TO_LOG
