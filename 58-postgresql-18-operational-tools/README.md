# 58 — PostgreSQL 18 Operational Tools

The curriculum already covers core PostgreSQL 18 features, replication, backup and client integration. A final audit found several PostgreSQL 18 operational interfaces that were documented only as references or not represented as runnable checklists.

## Added coverage
- `pg_amcheck` corruption/integrity checks
- `pg_verifybackup` backup verification
- `pg_combinebackup` for incremental-backup reconstruction
- `pgbench` repeatable workload generation
- libpq pipeline mode concepts
- PostgreSQL 18 protocol version awareness
- asynchronous I/O (AIO) operational considerations
- `pg_createsubscriber` migration workflow awareness
- logical-replication upgrade prerequisites

These are specialized operational tools, so they belong in a separate lab rather than the normal SQL regression job.