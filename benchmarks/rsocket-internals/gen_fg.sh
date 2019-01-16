#!/bin/bash

perf script > out.perf
../FlameGraph/stackcollapse-perf.pl out.perf > out.perf.folded
../FlameGraph/flamegraph.pl out.perf.folded > perf.data.svg
