# JIT, parallel query and TABLESAMPLE

Study when PostgreSQL can use parallel workers and when JIT compilation can help or hurt. Learn `TABLESAMPLE SYSTEM` and `BERNOULLI`, sampling bias, repeatability and the supplied `tsm_system_rows`/`tsm_system_time` extensions.

Lab questions: What prevents parallelism? When does JIT overhead outweigh execution savings? Is a sampled dataset representative enough for the decision being made?