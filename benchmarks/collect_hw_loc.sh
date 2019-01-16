
for t in r0 r1; do
    ssh root@$t 'apt-get install -y hwloc >/dev/null && hwloc-ls $(hostname).png && cat $(hostname).png' | \
        cat > assets/hw_${t}.png
done
