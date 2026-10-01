# Query Statistics Lab

PostgreSQL's pg_stat_statements module tracks planning and execution statistics and requires server configuration through shared_preload_libraries.

Lab steps:
1. Enable pg_stat_statements in a disposable PostgreSQL instance.
2. Restart the instance.
3. Create the extension in the learning database.
4. Execute several intentionally different queries.
5. Group observations by queryid, calls and total execution time.
6. Compare average execution time and row counts.
7. Reset statistics and repeat a controlled benchmark.

Use this lab together with EXPLAIN (ANALYZE, BUFFERS) rather than treating aggregate query statistics as a replacement for execution plans.