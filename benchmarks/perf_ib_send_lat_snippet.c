/* Note: only x86 CPUs which have rdtsc instruction are supported. */
typedef unsigned long long cycles_t;
static inline cycles_t get_cycles() {
    unsigned low, high;
    unsigned long long val;
    asm volatile("rdtsc" : "=a"(low), "=d"(high));
    val = high;
    val = (val << 32) | low;
    return val;
}

int run_iter_lat_send(struct pingpong_context *ctx,
                      struct perftest_parameters *user_param) {
    uint64_t scnt = 0; /* sent packets counter */
    uint64_t rcnt = 0; /* received packets counter */
    int poll = 0;
    int ne;
    int err = 0;
    struct ibv_wc wc;
    struct ibv_recv_wr *bad_wr_recv;
    struct ibv_send_wr *bad_wr;

    int size_per_qp = user_param->rx_depth;
    cycles_t end_cycle, start_gap = 0;

    ctx->wr[0].sg_list->length = user_param->size;
    ctx->wr[0].send_flags = 0;
    ctx->wr[0].send_flags |= IBV_SEND_INLINE;

    struct rusage rusage;
    getrusage(RUSAGE_SELF, &rusage);
    fprintf(stderr, "page reclaims => %ld\n v cs => %ld iv cs => %ld\n",
            rusage.ru_minflt, rusage.ru_nvcsw, rusage.ru_nivcsw);

    while (scnt < user_param->iters || rcnt < user_param->iters)

        // \begin to poll to handle a rwr
        /*
         * Get the received packet. make sure that the client won't enter here
         * until he sends his first packet (scnt < 1) server will enter here
         * first and wait for a packet to arrive (from the client)
         */
        if (rcnt < user_param->iters &&
            !(scnt < 1 && user_param->machine == CLIENT)) {
            do {
                ne = ibv_poll_cq(ctx->recv_cq, 1, &wc);

                if (ne > 0) {
                    if (wc.status != IBV_WC_SUCCESS) {
                        NOTIFY_COMP_ERROR_RECV(wc, rcnt);
                        return 1;
                    }

                    rcnt++;

                    if (rcnt + size_per_qp <= user_param->iters) {
                        if (ibv_post_recv(ctx->qp[0], &ctx->rwr[0],
                                          &bad_wr_recv)) {
                            fprintf(stderr, "Couldn't post recv: rcnt=%lu\n",
                                    rcnt);
                            return 15;
                        }
                    }
                } else if (ne < 0) {
                    fprintf(stderr, "poll CQ failed %d\n", ne);
                    return 1;
                }
            } while (ne == 0);
        }
    // \end to poll to handle a rwr

    // \begin to post a swr
    if (scnt < user_param->iters) {

        if (user_param->test_type == ITERATIONS)
            // typedef unsigned long long cycles_t;
            // ALLOCATE(user_param->tposted, cycles_t, tarr_size);
            user_param->tposted[scnt] = get_cycles();

        scnt++;

        if (scnt % user_param->cq_mod == 0 ||
            (user_param->test_type == ITERATIONS &&
             scnt == user_param->iters)) {
            poll = 1;
            ctx->wr[0].send_flags |= IBV_SEND_SIGNALED;
        }

        /* send the packet that's in index 0 on the buffer */
        err = ibv_post_send(ctx->qp[0], &ctx->wr[0], &bad_wr);

        if (poll == 1) {
            struct ibv_wc s_wc;
            int s_ne;

            /* wait until you get a cq for the last packet */
            do {
                s_ne = ibv_poll_cq(ctx->send_cq, 1, &s_wc);
            } while (s_ne == 0);

            if (s_ne < 0) {
                fprintf(stderr, "poll on Send CQ failed %d\n", s_ne);
                return FAILURE;
            }

            if (s_wc.status != IBV_WC_SUCCESS) {
                NOTIFY_COMP_ERROR_SEND(s_wc, scnt, scnt)
                return 1;
            }
            poll = 0;

            ctx->wr[0].send_flags &= ~IBV_SEND_SIGNALED;
        }
    }
    // \end to post a swr

    getrusage(RUSAGE_SELF, &rusage);
    fprintf(stderr, "page reclaims => %ld\n v cs => %ld iv cs => %ld\n",
            rusage.ru_minflt, rusage.ru_nvcsw, rusage.ru_nivcsw);

    // @print_report_lat
    // for (i = 0; i < measure_cnt; ++i) {
    //     delta[i] = user_param->tposted[i + 1] - user_param->tposted[i];
    // }

    return 0;
}
