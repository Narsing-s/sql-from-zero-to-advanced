# 42 — PostgreSQL Production Patterns

Remaining high-value production patterns are collected here as operational playbooks.

- connection pooling and connection budgets
- PgBouncer architecture
- statement, lock and idle-in-transaction timeouts
- SKIP LOCKED worker queues
- advisory locks
- LISTEN/NOTIFY versus durable messaging
- materialized-view refresh strategy
- bulk COPY
- timezone and DST correctness
- collation and deterministic ordering
- partition lifecycle
- RLS tenant isolation
- pg_stat_statements
- schema drift and performance regression
- backup verification and restore drills

Production rule: evaluate correctness, concurrency, failure behavior, observability, security, recovery and cost together.