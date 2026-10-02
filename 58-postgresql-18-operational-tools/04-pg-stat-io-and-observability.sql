-- PostgreSQL I/O observability evidence.
-- Run on a PostgreSQL version that exposes pg_stat_io.

SELECT backend_type,
       object,
       context,
       reads,
       read_time,
       writes,
       write_time,
       hits,
       evictions
FROM pg_stat_io
ORDER BY backend_type, object, context;

-- Compare this evidence with query statistics, EXPLAIN (ANALYZE, BUFFERS),
-- WAL activity and filesystem metrics. No single view proves overall
-- database performance.
