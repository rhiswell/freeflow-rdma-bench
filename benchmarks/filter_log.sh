cat ff_lowCPU_ib_send_lat_U.log | awk -F',' '{ if ( $2 < 600) printf "%d,%f\n",$1,$2 }'
