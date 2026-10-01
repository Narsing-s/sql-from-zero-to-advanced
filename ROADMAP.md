# SQL Learning Roadmap

## Phase 1 — Setup
- Install PostgreSQL
- Install pgAdmin
- Configure a database
- Verify client connectivity
- Learn database/schema/table terminology

## Phase 2 — Beginner
- SELECT
- DISTINCT
- WHERE
- AND/OR/NOT
- IN/BETWEEN/LIKE
- ORDER BY
- LIMIT/OFFSET
- NULL
- INSERT/UPDATE/DELETE
- Constraints

## Phase 3 — Intermediate
- INNER/LEFT/RIGHT/FULL JOIN
- GROUP BY
- HAVING
- COUNT/SUM/AVG/MIN/MAX
- Subqueries
- CASE
- String/date functions
- UNION/INTERSECT/EXCEPT

## Phase 4 — Advanced
- CTE
- Recursive CTE
- Window functions
- Views
- Functions
- Procedures
- Triggers
- JSON and PostgreSQL-specific features

## Phase 5 — Engineering
- ACID
- Transactions
- Isolation
- Locks/deadlocks
- Indexes
- EXPLAIN ANALYZE
- Query optimization
- Roles and privileges
- Backup/restore concepts
- Production monitoring and alerting
- Incident response and RCA
- Capacity and connection troubleshooting

## Phase 6 — Project
Build the banking database, write reports, implement transfers, auditing and production scenarios.

## Phase 7 — Production Operations
- Backup/recovery drills
- RPO/RTO
- Monitoring and alerting
- Connection exhaustion
- Blocking/deadlocks
- Replication lag
- Incident response and RCA

## Phase 8 — Interview
Solve beginner, intermediate, advanced and incident-based SQL questions.


## Phase 9 — Runnable Lab Engineering
- Advisory locks and SKIP LOCKED worker queues
- LISTEN/NOTIFY and durable-messaging boundaries
- Materialized-view refresh
- COPY and bulk loading
- Time zones, DST and collation
- Partition lifecycle and pruning
- RLS tenant-isolation testing
- Query statistics with pg_stat_statements

## Phase 10 — Production Readiness
- Connection pool budgets and PgBouncer architecture
- Schema drift detection
- Performance regression baselines
- Backup verification and restore drills
- Recovery evidence and operational acceptance criteria

## Completion rule
Do not stop at reading. For each major topic, run the corresponding lab, record the observation, verify the result, clean up, and explain the production trade-offs.


## Phase 11 — Automated Verification
- Docker PostgreSQL 18.6 test environment
- deterministic fixtures
- SQL assertions with ON_ERROR_STOP
- GitHub Actions integration template
- lab safety and version contracts

## Phase 12 — Application and Concurrency
- JDBC/Python/Node client boundaries
- prepared statements and pooling
- transaction retry semantics
- MVCC and isolation
- serialization/deadlock handling
- advanced locking patterns

## Phase 13 — Data Movement
- staging and validation
- COPY and bulk loading
- bad-row quarantine
- export consistency
- encoding and delimiter handling


## Phase 14 — Recovery and Replication
- backup/restore drills
- migration rehearsal
- PITR concepts
- two-node logical replication
- conflict and lag analysis

## Phase 15 — Quality and Performance Engineering
- SQL linting/style
- EXPLAIN-based review
- pg_stat_statements and wait events
- performance baselines
- reproducible workload measurements
