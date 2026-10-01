# 54 — Multi-Session and Cluster Labs

This stage turns environment-dependent topics into explicit lab contracts.

## Labs

### 01 — Concurrency harness
Use two PostgreSQL sessions to reproduce row-lock blocking, NOWAIT failure, SKIP LOCKED queue consumption, deadlock detection, serialization failure and advisory-lock coordination.

### 02 — Logical replication harness
Use publisher and subscriber PostgreSQL 18 containers to demonstrate publication/subscription, initial synchronization, ongoing DML, replication-slot inspection, subscription monitoring, generated-column replication, conflict/error observation and teardown.

### 03 — Backup/restore harness
Use an isolated PostgreSQL container to demonstrate pg_dump, pg_restore, integrity verification, restore timing and schema/data-only artifacts.

These labs are outside lightweight CI because PostgreSQL itself separates ordinary regression tests from isolation, recovery/physical replication, subscription and client tests.

## Safety
Never run destructive or recovery exercises against production. Use disposable containers and named test databases only.