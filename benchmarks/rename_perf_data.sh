
PREFIX=$1

function print_usage_then_die()
{
    echo "$0 prefix"
}

[[ -z "$PREFIX" ]] && print_usage_then_die

mv perf.data ${PREFIX}.data
mv perf.data.svg  ${PREFIX}.data.svg
