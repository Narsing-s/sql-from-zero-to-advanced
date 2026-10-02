# 41 — Runnable PostgreSQL Lab System

This stage turns the broad curriculum into repeatable, executable labs.

## Lab contract
1. Prerequisites
2. Setup
3. Exercise
4. Expected observation
5. Verification query
6. Cleanup
7. Safety notes
8. PostgreSQL version

## Runnable coverage
- advisory locks and SKIP LOCKED job queues
- LISTEN/NOTIFY
- materialized-view refresh
- COPY bulk loading
- timezone and collation behavior
- partition maintenance
- row-level security
- pg_stat_statements
- advanced index families (B-tree, Hash, GIN, GiST, SP-GiST, BRIN)
- workload resource controls (work_mem, timeouts, temp limits)
- progress monitoring for VACUUM, indexes, ANALYZE and COPY
- CLUSTER / VACUUM FULL progress monitoring (pg_stat_progress_cluster)
- event-trigger DDL auditing
- replication-origin progress tracking (pg_replication_origin_status and replication-origin functions)

Run production-style labs only in a disposable learning database.