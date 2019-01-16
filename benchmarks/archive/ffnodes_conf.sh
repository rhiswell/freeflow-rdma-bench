#!/bin/bash

# tuple(ffr_id, guest_ip, host_ip, app_name)
# 10 10.40.0.0 192.168.1.140 mb-server
# 11 10.40.0.1 192.168.1.140 memcached
# 12 10.40.0.2 192.168.1.140 nginx
# 13 10.40.0.3 192.168.1.140 postgresql
# 14 10.40.0.4 192.168.1.140 kafka
# 20 10.44.0.0 192.168.1.141 mb-client
# 21 10.44.0.1 192.168.1.141 memtier-benchmark
# 22 10.44.0.2 192.168.1.141 wrk2
# 23 10.44.0.3 192.168.1.141 pgbench
# 24 10.44.0.4 192.168.1.141 kafka-producer-perf-test

app_ids=()
app_ids[${#app_ids[@]}]="mb-server"
app_ids[${#app_ids[@]}]="mb-client"

declare -A ffr_id
ffr_id+=( ["mb-server"]="10" )
ffr_id+=( ["mb-client"]="20" )

declare -A guest_ip
guest_ip+=( ["mb-server"]="10.40.0.0" )
guest_ip+=( ["mb-client"]="10.44.0.0" )

declare -A host_ip
host_ip+=( ["mb-server"]="192.168.1.140" )
host_ip+=( ["mb-client"]="192.168.1.141" )

