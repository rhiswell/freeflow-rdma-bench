
docker image inspect ffnode >/dev/null 2>&1 && docker image rm ffnode
cat ffnode.tar | docker import - ffnode

docker image inspect ffrouter >/dev/null 2>&1 && docker image rm ffrouter
cat ffrouter.tar | docker import - ffrouter
