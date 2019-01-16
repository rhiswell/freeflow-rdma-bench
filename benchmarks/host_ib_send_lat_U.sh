
NR_ITERS=1000000; ssh root@r1 "screen -d -m ib_send_lat -n $NR_ITERS" && ib_send_lat -U -n $NR_ITERS 192.168.10.141 | egrep "^[0-9]" | awk -F',' '{ if ($2 > 60) print $1 $2 }'
