
#include <math.h>

#define N 10000000UL

#define C(n)                                                                   \
    do {                                                                       \
        unsigned long i;                                                       \
        double x = 42;                                                         \
        for (i = 0; i < (n); i++)                                              \
            x = sin(x);                                                        \
    } while (0)

void baz() { C(N); }

void bar() { C(2 * N); }

void foo() {
    C(3 * N);
    bar();
    baz();
}

int main() {
    foo();

    return 0;
}
