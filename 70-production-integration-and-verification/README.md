# Stage 70 — Production Integration & Verification

Stage 70 turns remaining application-integration and repository-engineering gaps into explicit, runnable guidance.

## Application transaction boundaries
- Keep transactions around one coherent business operation.
- Do not hold a transaction open during remote HTTP calls, user input, queues or long non-database work.
- Document transaction owner, isolation level, commit/rollback boundary, timeout, retry policy and idempotency.

## Parameter binding
Always bind application values instead of constructing SQL with string concatenation.

```sql
PREPARE customer_lookup(bigint) AS SELECT customer_id, customer_name FROM customers WHERE customer_id = $1;
```

Application clients should use their driver's parameter API. Escaping is not a substitute for parameter binding.

## Retryable failures
Serialization failures and deadlocks can be retry candidates only when the complete transaction is safe to retry. Retry with a fresh transaction, bounded attempts and backoff/jitter. Do not blindly retry every database error.

## Connection pools
Treat pools as concurrency control. Monitor pool size, active/idle connections, acquisition wait time, exhaustion, database connection limits, transaction duration and idle-in-transaction sessions.

## Cursor and streaming patterns
For large results use bounded/streaming consumption. Document chunk size, transaction lifetime, cancellation, timeout, backpressure and cleanup.

## Timeout hierarchy
Define separate budgets for connection, pool acquisition, statement, lock, transaction and API/request timeouts. Keep the end-to-end budget consistent with the intended SLA.

## GitHub Actions database verification
CI should start a disposable PostgreSQL environment, apply schema/migrations, load deterministic fixtures, execute assertions, run integration tests, collect failure evidence and destroy the environment. Use an explicit PostgreSQL version matrix when portability matters.

Example assertion:
```sql
DO $$ BEGIN IF (SELECT count(*) FROM sql_stage69.orders) <> 3 THEN RAISE EXCEPTION 'fixture verification failed'; END IF; END $$;
```

## Repository structure audit
Every stage should provide learning objectives, theory/reference material, runnable examples when claiming runnable coverage, expected observations, cleanup, exercises where appropriate, curriculum links and valid relative links. Theory-only stages must say so.

## Backup/restore rehearsal
A backup is operationally useful only after restore has been tested. Record backup ID, PostgreSQL version, backup method, restore target, duration, validation queries, recovered object/row counts, RPO/RTO and remediation. Use an isolated target.

## Logical replication verification
Test initial sync, INSERT/UPDATE/DELETE, replica identity, row/column filtering, sequence/DDL limitations, conflicts, slot/WAL retention, lag and teardown.

## Deterministic locale/timezone tests
Set timezone explicitly and record collation/locale for ordering-sensitive tests.

```sql
SET TIME ZONE 'UTC';
SELECT TIMESTAMPTZ '2026-03-29 00:30:00+00' AT TIME ZONE 'Asia/Kolkata';
```

## Extension/version audit
Record required PostgreSQL version, extension name/minimum version, installation prerequisites, permissions, portability impact and fallback. Useful discovery:

```sql
SELECT version();
SELECT extname, extversion FROM pg_extension ORDER BY extname;
```

## Production acceptance
A production-ready module must be reproducible, environment-explicit, safely setup/cleaned, automatically verifiable where possible, clear about destructive actions, concurrency and security, evidence-based on performance, and documented for recovery.

## Final lab
Use a disposable database to run a deterministic fixture, parameterized queries, a controlled retryable transaction failure, metadata capture and verification assertions, then record the result as a reproducible test artifact.