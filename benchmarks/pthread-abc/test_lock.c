
#include <assert.h>
#include <errno.h>
#include <pthread.h>
#include <stdio.h>

#define handle_error(msg)                                                      \
    do {                                                                       \
        perror(msg);                                                           \
        exit(EXIT_FAILURE);                                                    \
    } while (0)

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

static void *thread_func(void *arg) {
    while (1) {
        pthread_mutex_lock(&mutex);
        pthread_mutex_unlock(&mutex);
    }
}

int main() {
    int rc;
    pthread_t tid;

    rc = pthread_create(&tid, NULL, thread_func, NULL);
    assert(rc == 0);

    pthread_join(tid, NULL);

    return 0;
}
