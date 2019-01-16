
all: clean perf-test

perf-test: perf-test.c
	gcc -g -Wall -pedantic $^ -lm -o $@

clean:
	rm -f perf-test
