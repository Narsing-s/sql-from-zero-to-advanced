# Stage 66 — Logical Replication & CDC Deep Dive

This stage consolidates PostgreSQL 18 logical-replication topics that were distributed across earlier labs: architecture, initial synchronization, row filters, column lists, generated-column replication, conflicts, failover, security, upgrades, worker capacity and CDC idempotency.

PostgreSQL 18 documents these as distinct logical-replication areas, including failover, row filters, column lists, generated columns, conflicts, restrictions, architecture, monitoring, security and upgrade procedures. citeturn0search0turn0search1

## Contents
- 40 theory questions and answers
- 30 production scenarios
- Publisher/subscriber architecture
- Initial snapshot and table synchronization
- Row filters and column lists
- Generated-column replication
- Replica identity
- Conflict handling
- Logical replication failover
- Replication slots and WAL retention
- Parallel apply and worker capacity
- Security and privilege boundaries
- Schema/DDL/sequence/large-object restrictions
- Major-version upgrade patterns
- CDC duplicate delivery and idempotency
- Monitoring and incident response
