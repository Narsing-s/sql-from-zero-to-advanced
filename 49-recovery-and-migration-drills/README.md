# 49 — Recovery and Migration Drills

These exercises are deliberately isolated from normal CI because backup, restore, replication and destructive migrations require dedicated environments.

## Backup
- pg_dump custom format
- pg_restore
- pg_dumpall
- schema-only/data-only backups
- checksum and artifact verification
- restore into a clean database
- restore timing measurement

## Migration
- expand/contract migrations
- backward-compatible schema changes
- NOT VALID constraints and validation
- online index creation
- lock-time budgets
- backfill batching
- rollback/forward-fix decisions
- migration rehearsal

## Recovery
- PITR concepts
- WAL archive verification
- recovery target selection
- restore validation
- RPO/RTO measurement
- post-restore integrity checks

Never point these drills at production. PostgreSQL's own test suites separate crash recovery, physical replication and logical replication from ordinary regression tests, which is the model used here.