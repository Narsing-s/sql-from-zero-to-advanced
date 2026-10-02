# SQL Production Scenario Questions & Answers

Use this as a production-interview drill. Answer in this order:
**Symptoms → Scope → Evidence → Hypothesis → Safe mitigation → Root cause → Permanent fix → Validation → Prevention.**

## Query and performance

### Scenario 1 — A query became slow after the table grew 100x.
**Answer:** Capture the exact SQL and parameters. Compare old and current plans, inspect EXPLAIN (ANALYZE, BUFFERS), row-estimate accuracy, statistics, selectivity, indexes, I/O and locks. Fix the measured cause instead of automatically adding an index.

### Scenario 2 — PostgreSQL ignores an expected index.
**Answer:** Check table size, selectivity, statistics, data correlation, casts/functions on indexed columns and estimated versus actual rows. A sequential scan can be cheaper. Validate with representative data.

### Scenario 3 — CPU increased immediately after a deployment.
**Answer:** Correlate query metrics with deployment time, identify top CPU/query consumers, compare plans, check query frequency and changed predicates. Roll back or disable the offending path if necessary, then fix and validate.

### Scenario 4 — A query times out.
**Answer:** Determine whether it is lock waiting, CPU, I/O, bad planning or resource contention. Inspect wait events and blockers. Cancel safely when possible, then correct the underlying cause.

### Scenario 5 — OFFSET pagination is slow on deep pages.
**Answer:** Replace large OFFSET pagination with keyset/seek pagination using a stable indexed ordering key such as timestamp plus unique ID.

### Scenario 6 — Temporary files suddenly consume disk.
**Answer:** Identify queries producing large sorts/hashes, inspect work_mem and concurrency, and review query plans. Do not increase work_mem globally without considering per-operation memory multiplication.

## Transactions and concurrency

### Scenario 7 — Two transactions deadlock.
**Answer:** Inspect deadlock evidence and lock relationships, identify the cycle, standardize lock acquisition order, shorten transactions, remove unnecessary locking, and retry safe transient failures.

### Scenario 8 — A DDL migration is blocked.
**Answer:** Find the waiting and blocking PIDs, lock modes and transaction age. Determine the business impact before cancellation/termination. Redesign the migration for safer lock acquisition where possible.

### Scenario 9 — Idle-in-transaction sessions accumulate.
**Answer:** Identify owners and transaction age. These sessions can hold locks/snapshots and delay cleanup. Fix application transaction boundaries and use a timeout as a guardrail.

### Scenario 10 — Serialization failures increase under load.
**Answer:** Confirm isolation and SQLSTATE, identify conflicting access patterns, retry the entire transaction with bounded backoff, and reduce transaction scope where possible.

### Scenario 11 — A job queue processes the same job twice.
**Answer:** Use an atomic state transition with row locking/SKIP LOCKED or an advisory lock where appropriate, and enforce a unique business key if duplicates are invalid.

### Scenario 12 — SELECT-then-INSERT creates duplicates.
**Answer:** Replace the race-prone pattern with a unique constraint plus INSERT ... ON CONFLICT. Let the database enforce the invariant.

## Data correctness

### Scenario 13 — A report has duplicate customers.
**Answer:** Determine the intended row grain and inspect join cardinality. Fix the one-to-many join or aggregation rather than adding DISTINCT blindly.

### Scenario 14 — A financial total is wrong.
**Answer:** Preserve evidence, identify exact source rows, reconcile counts and totals, and check duplicate joins, missing rows, rounding, currency and partial loads. Correct through an auditable process.

### Scenario 15 — NULL values cause missing report rows.
**Answer:** Reproduce the predicate and explain three-valued logic. Use IS NULL/IS NOT NULL where required and only use COALESCE when it represents the business rule.

### Scenario 16 — ETL fails on a foreign key.
**Answer:** Identify missing parent keys and load order. Validate staging data, load dependencies first, and handle legitimate late-arriving dimensions explicitly.

### Scenario 17 — A batch partially loaded before failure.
**Answer:** Determine what committed and the transaction boundary. Use atomic transactions when required, or durable checkpoints and idempotency when restartable processing is required.

## Availability, backup and replication

### Scenario 18 — The primary database is unavailable.
**Answer:** Confirm scope and connectivity, inspect cluster/service/storage/network evidence, follow the tested failover runbook if HA exists, and validate application read/write behavior after recovery.

### Scenario 19 — Replication lag keeps increasing.
**Answer:** Determine whether sender, network, receiver/replay or subscriber apply is the bottleneck. Inspect replication state, WAL retention and long transactions before changing retention settings.

### Scenario 20 — A replication slot retains huge WAL.
**Answer:** Identify the slot and consumer position. Determine whether the consumer is stopped, slow or abandoned. Recover the consumer or remove an abandoned slot only after assessing data-loss consequences.

### Scenario 21 — A user accidentally deleted important rows.
**Answer:** Preserve evidence and recovery options. Restore a base backup plus WAL into an isolated environment, recover to a point before deletion, verify the data, and perform controlled extraction or recovery according to the runbook.

### Scenario 22 — Restore succeeds but the application fails.
**Answer:** Verify schema version, extensions, roles, privileges, identity/sequence state, application migrations, configuration and data integrity. Restore success does not equal application readiness.

### Scenario 23 — Failover happened but clients use the old primary.
**Answer:** Check DNS/service discovery/pooler routing and stale connection pools. Confirm the actual primary, update routing through the approved mechanism, and validate writes.

## Security

### Scenario 24 — A tenant can see another tenant's rows.
**Answer:** Treat it as a security incident. Inspect role privileges, RLS policies, application context and SECURITY DEFINER functions. Close the exposure, review evidence and add automated cross-tenant tests.

### Scenario 25 — Someone proposes a production superuser for the application.
**Answer:** Identify the exact required operations and create a least-privileged role. Separate application, migration and administration privileges.

### Scenario 26 — Dynamic SQL may allow injection.
**Answer:** Parameterize values with EXECUTE ... USING, safely quote identifiers, allow-list identifier choices, and review SECURITY DEFINER code carefully.

### Scenario 27 — A database credential is committed to Git.
**Answer:** Remove the secret from source control, rotate it immediately, review history/access according to security policy, and move credentials to secret management.

## Schema changes

### Scenario 28 — A huge table needs an index during business hours.
**Answer:** Assess storage, write load and locking. Use CREATE INDEX CONCURRENTLY when appropriate, understand its restrictions/failure modes, monitor progress, and validate the resulting plan.

### Scenario 29 — A huge table needs a new NOT NULL column.
**Answer:** Prefer an expand/contract approach: introduce compatibility, deploy application support, backfill in controlled batches, validate, then enforce the final constraint with a lock-conscious strategy.

### Scenario 30 — A column type must change.
**Answer:** Check rewrite/lock behavior, dependent indexes/functions and client compatibility. For high risk, use a compatibility migration with new representation, controlled backfill and cutover.

### Scenario 31 — A migration failed halfway.
**Answer:** Determine whether it was transactional and what committed. Inspect schema state and application compatibility, then follow the migration tool's supported recovery procedure instead of rerunning blindly.

## ETL and data engineering

### Scenario 32 — Incremental ETL misses late-arriving data.
**Answer:** A single timestamp watermark can miss equal timestamps, clock skew or late updates. Use an overlap window, deterministic timestamp-plus-key watermark, CDC or reconciliation, and make reprocessing idempotent.

### Scenario 33 — The same source file is processed twice.
**Answer:** Store an immutable ingestion identifier/checksum and enforce uniqueness. Persist processing state so retries become no-ops or controlled updates.

### Scenario 34 — Source and target counts differ.
**Answer:** Reconcile by business key and time/partition range. Check filters, duplicates, rejects, deletes and aggregate control totals. Row-count equality alone is not sufficient proof.

### Scenario 35 — Dimension changes break historical reporting.
**Answer:** Define whether history should preserve the old dimension state. For SCD2, close the previous version and create a new effective-dated version atomically.

## Capacity and maintenance

### Scenario 36 — max_connections is reached.
**Answer:** Inspect pg_stat_activity and connection-pool metrics. Determine whether the cause is leaks, pool oversizing, connection storms, long transactions or legitimate demand. Fix client behavior before raising the limit.

### Scenario 37 — Autovacuum cannot keep up.
**Answer:** Inspect dead tuples, table churn, long transactions, vacuum progress and per-table settings. Remove blockers and tune hot tables based on measured workload.

### Scenario 38 — A table is bloated.
**Answer:** Confirm bloat and investigate dead tuples, vacuum effectiveness, long transactions and update patterns. Choose VACUUM, REINDEX, CLUSTER, VACUUM FULL or redesign according to lock/availability requirements.

### Scenario 39 — WAL volume suddenly increases.
**Answer:** Correlate WAL with bulk changes, index builds, checkpoints, replication slots, logical decoding and application changes. Determine whether it is expected. Never delete PostgreSQL WAL files manually.

### Scenario 40 — Disk usage is rapidly increasing.
**Answer:** Separate table/index growth, WAL retention, archive backlog and temporary files. Identify the source before deleting or changing capacity settings.

## Advanced SQL

### Scenario 41 — A recursive query loops.
**Answer:** Add cycle detection/visited-node tracking and a safe depth boundary. PostgreSQL recursive SEARCH/CYCLE features can make traversal behavior explicit.

### Scenario 42 — JSONB queries are slow.
**Answer:** Identify operators and access patterns, then choose suitable GIN/expression indexes. Move stable, frequently filtered attributes into relational columns when appropriate.

### Scenario 43 — A prepared statement gets a bad plan.
**Answer:** Inspect generic versus custom plan behavior and parameter distribution. Compare representative plans and test plan_cache_mode when justified rather than forcing a mode without measurement.

### Scenario 44 — A partitioned query scans too many partitions.
**Answer:** Inspect EXPLAIN for partition pruning. Check predicates, casts/expressions and partition-key alignment.

### Scenario 45 — A materialized view is stale.
**Answer:** Define a freshness SLA, schedule/trigger refreshes and measure refresh duration. If full refresh no longer meets the SLA, redesign the summary pipeline.

## Incident and interview scenarios

### Scenario 46 — The interviewer asks, “Would you add an index?”
**Answer:** Ask for the exact query, workload, data distribution, existing indexes and plan evidence. Explain read benefit versus write/storage/maintenance cost.

### Scenario 47 — “How would you troubleshoot any SQL issue?”
**Answer:** Start with impact and scope, capture evidence, identify waits/resource usage, inspect SQL/plan/schema/data, form a hypothesis, apply the safest reversible mitigation, establish root cause, then implement and validate the permanent fix.

### Scenario 48 — A fix worked but root cause is unknown.
**Answer:** Treat it as mitigated, not resolved. Preserve evidence, compare metrics, reproduce safely where possible, document uncertainty and create follow-up work.

### Scenario 49 — Someone asks you to kill a backend immediately.
**Answer:** Identify PID, user, database, query, transaction age, lock impact and owner first. Prefer cancellation before termination when safe, and follow the approved production runbook.

### Scenario 50 — An incident was caused by a missing constraint.
**Answer:** Reconcile existing bad data first, then add the invariant at the database layer, deploy safely, add regression coverage and ensure application behavior is compatible.

### Scenario 51 — A backup job reports success but recovery has never been tested.
**Answer:** Treat recoverability as unproven. Perform a controlled restore drill, verify schema/data/application readiness and measure actual RTO/RPO against the target.

### Scenario 52 — An alert says replication is healthy but business data is stale.
**Answer:** Check what the alert actually measures. Replication transport can be healthy while apply is delayed or the application reads from an unexpected node. Validate end-to-end freshness.

### Scenario 53 — A query is fast in staging but slow in production.
**Answer:** Compare data volume/distribution, statistics, indexes, parameters, configuration, hardware, concurrency and plan selection. Production behavior requires representative workload evidence.

### Scenario 54 — A new index improves reads but writes become slower.
**Answer:** Measure index maintenance cost and write amplification. Keep it only if the workload-level benefit justifies the cost; otherwise redesign the index or query.

### Scenario 55 — A release introduces duplicate events.
**Answer:** Inspect transaction boundaries, retry behavior, unique keys and event/outbox semantics. Make event creation idempotent and add a uniqueness invariant where duplicates are invalid.

### Scenario 56 — An application retries a timed-out transaction.
**Answer:** First determine whether the original transaction committed. Retrying blindly can duplicate side effects. Use idempotency keys, transaction outcome checks and database constraints.

### Scenario 57 — A database is under memory pressure.
**Answer:** Inspect concurrent operations, work_mem, maintenance work, connection count, temp activity and operating-system pressure. Remember that work_mem is per operation, not a single global allocation.

### Scenario 58 — A customer asks why a query result order changed.
**Answer:** If the query had no ORDER BY, explain that row order was never guaranteed. Add an explicit stable ordering, preferably including a unique tie-breaker for pagination.

### Scenario 59 — A migration requires an exclusive lock on a large table.
**Answer:** Estimate lock duration and impact, inspect active transactions, schedule a maintenance window if required, or redesign into smaller compatibility steps. Never assume a metadata change is automatically instant.

### Scenario 60 — An interviewer asks for the difference between logical and physical replication.
**Answer:** Physical replication reproduces the database cluster at the physical/WAL level and is commonly used for HA. Logical replication sends logical row changes and supports selective publication/subscription use cases. The correct choice depends on HA, migration and data-distribution requirements.

## Universal scenario answer template

1. **Impact:** What users/data/workload are affected?
2. **Scope:** Query, table, database, cluster or application?
3. **Evidence:** Which SQL, logs, metrics and system views prove the state?
4. **Hypothesis:** What mechanism could explain it?
5. **Safe mitigation:** What reduces impact without creating a larger incident?
6. **Root cause:** What actually produced the failure?
7. **Permanent fix:** What design/code/configuration change prevents recurrence?
8. **Validation:** What measurable evidence proves recovery?
9. **Prevention:** What alert, test, guardrail or runbook should be added?

Never claim a root cause from symptoms alone.
