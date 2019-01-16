
#include <stdio.h>
#include <pthread.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <stdlib.h>

void *thread_func (void *thread_args) {  }

inline int new_thread() {
	pthread_t *tid = calloc(1, sizeof(pthread_t));
	int rc = pthread_create(tid, NULL, thread_func, NULL);
	pthread_detach(*tid);

	return rc;
}

int main()
{
	int rc = 0, count=0;
	struct rlimit rlim;

	getrlimit(RLIMIT_NPROC, &rlim);

	printf("RLIMIT_NPROC: soft -> %d, hard -> %d\n", rlim.rlim_cur, rlim.rlim_max);

	while ((rc = new_thread()) == 0)
		count++;

	printf("Maximum number of thread within a process is %d\n", count);
}
