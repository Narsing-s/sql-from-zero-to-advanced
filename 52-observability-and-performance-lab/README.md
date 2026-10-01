# 52 — Observability and Performance Lab

## Measure
- query latency
- planning time
- execution time
- rows read versus returned
- buffer hits/reads
- temporary files
- lock waits
- connection utilization
- vacuum/analyze health
- replication lag
- checkpoint/WAL pressure
- cache effectiveness

## Experiments
- EXPLAIN and EXPLAIN ANALYZE
- pg_stat_statements
- auto_explain
- wait-event inspection
- index effectiveness
- statistics quality
- parallel query
- JIT
- partition pruning
- regression baselines

Every optimization exercise should record the workload, PostgreSQL version, schema/data volume, query plan and before/after measurements.