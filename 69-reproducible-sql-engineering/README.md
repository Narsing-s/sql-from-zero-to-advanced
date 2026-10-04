# Stage 69 — Reproducible SQL Engineering & Curriculum Acceptance

Stage 69 closes the remaining engineering-practice gaps around reproducibility. The goal is to make SQL lessons and benchmarks repeatable across machines, PostgreSQL versions and CI runners.

## Learning objectives
- Capture PostgreSQL/server, extension, schema, locale and timezone metadata with benchmark results.
- Build deterministic fixtures that can be recreated and cleaned safely.
- Write executable SQL assertions instead of relying on visual inspection.
- Classify labs as SAFE, STATE-CHANGING or DESTRUCTIVE.
- Design multi-session tests for isolation, locking and concurrency behavior.
- Define performance baselines with workload, scale, version and configuration recorded.
- Define acceptance criteria that distinguish theory coverage from executable coverage.

## Reproducibility metadata
Record at minimum: PostgreSQL version (`SHOW server_version`), server OS/architecture when relevant, database encoding/collation, `SHOW TimeZone`, extension versions, schema/fixture version, row counts/data scale, relevant configuration, query identifier, execution method such as `EXPLAIN (ANALYZE, BUFFERS, SETTINGS)`, and a test-run identifier.

Do not compare benchmark numbers as equivalent when workload, scale, PostgreSQL version or important configuration differs.

## Deterministic fixture pattern
Create an isolated schema, insert explicit stable values, avoid uncontrolled wall-clock/random dependencies, provide cleanup, and make the fixture safe to rerun.

```sql
DROP SCHEMA IF EXISTS sql_stage69 CASCADE;
CREATE SCHEMA sql_stage69;

CREATE TABLE sql_stage69.orders (
    order_id bigint PRIMARY KEY,
    customer_id bigint NOT NULL,
    amount numeric(12,2) NOT NULL CHECK (amount >= 0)
);

INSERT INTO sql_stage69.orders(order_id, customer_id, amount)
VALUES (1001, 10, 25.00), (1002, 10, 40.00), (1003, 20, 15.00);
```

## Executable assertions
Assertions should fail loudly when expected state is wrong:

```sql
DO $$
DECLARE
    actual_count bigint;
BEGIN
    SELECT count(*) INTO actual_count FROM sql_stage69.orders;
    IF actual_count <> 3 THEN
        RAISE EXCEPTION 'fixture assertion failed: expected 3 rows, got %', actual_count;
    END IF;
END $$;
```

For application tests, assert stable columns, row counts and key values rather than formatted console output.

## Safe/destructive classification
- **SAFE** — read-only or isolated temporary work.
- **STATE-CHANGING** — writes or DDL against a disposable fixture.
- **DESTRUCTIVE** — DROP, TRUNCATE, production-impacting maintenance, or recovery commands.

Destructive labs require warnings, prerequisites, a disposable target, recovery guidance where applicable, and explicit verification.

## Multi-session isolation harness
Concurrency lessons should document Session A, Session B, isolation level, exact statements, expected blocking/visibility/results, lock observation through `pg_stat_activity` and `pg_locks`, cleanup, and retry behavior.

## Performance baseline
Capture: run_id, PostgreSQL version, fixture version, row count, query ID/hash, workload, configuration, execution plan, planning time, execution time, buffer hits/reads, temporary blocks, parallel workers and notes.

The baseline is a reference, not a promise. Investigate regressions only after confirming that environment and workload are comparable.

## Curriculum acceptance criteria
- **Theory-complete:** definition, purpose, mental model, examples and important edge cases.
- **Lab-complete:** executable setup, expected observations, cleanup and verification.
- **Production-complete:** operational guidance, failure modes, monitoring/troubleshooting, security/concurrency considerations and recovery/rollback guidance where relevant.

## Final verification checklist
- [ ] Metadata captured for every benchmark.
- [ ] Fixtures are deterministic and rerunnable.
- [ ] Assertions fail on incorrect results.
- [ ] Labs are classified SAFE / STATE-CHANGING / DESTRUCTIVE.
- [ ] Concurrency labs define both sessions and expected observations.
- [ ] Performance comparisons include workload/version/configuration metadata.
- [ ] Theory, lab and production completeness are tracked separately.