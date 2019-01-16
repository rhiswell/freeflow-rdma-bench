
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

#define BUFSZ (4 * 1024)

#define perror_and_die(msg)                                                    \
    do {                                                                       \
        perror(msg);                                                           \
        exit(EXIT_FAILURE);                                                    \
    } while (0)

int main() {
    // char *addr = malloc(BUFSZ);
    // memset(addr, 0xff, BUFSZ);

    void *addr = memalign(BUFSZ, BUFSZ);

    int is_aligned = (((long)addr) % (4 * 1024)) == 0 ? 1 : 0;

    printf("addr -> %ld, align -> %d\n", (long)addr, is_aligned);

    char *mapped_addr =
        mmap(addr, BUFSZ, PROT_READ | PROT_WRITE,
             MAP_SHARED | MAP_FIXED | MAP_LOCKED | MAP_ANON, 0, 0);
    if (mapped_addr == MAP_FAILED)
        perror_and_die("mmap");

    printf("addr -> %ld, mmapped_addr -> %ld\n", (long)addr, (long)mapped_addr);

    return 0;
}
