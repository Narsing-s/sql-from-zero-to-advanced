# Regression, Isolation, Recovery and Replication Testing

## 1. Why regression testing matters

A SQL change is not complete merely because one manual query works. A regression test proves that intended behavior remains stable after future changes.

A useful database test has controlled setup, deterministic input, explicit expected result, cleanup, repeatability, failure evidence, and minimal dependence on environment-specific ordering.

## 2. Test layers

| Layer | Purpose | Examples |
|---|---|---|
| Unit-style SQL test | One function/query behavior | NULL handling, validation |
| Regression test | Prevent behavior regressions | query output, DDL behavior |
| Isolation test | Concurrent transaction behavior | locks, serialization, races |
| Recovery test | Failure/restart behavior | crash recovery, WAL |
| Replication test | Replica correctness | physical/logical replication |
| Integration test | Client + database | application transaction behavior |
| Performance test | Latency/resource behavior | plans, IO, concurrency |
| Security test | Authorization boundaries | roles, RLS, injection |

## 3. pg_regress

pg_regress is used by PostgreSQL regression infrastructure. Core tests can be run with make check; installed-server testing can use make installcheck. Additional suites cover concurrency, recovery, logical replication, authentication, client programs, and extensions.

Conceptual flow:

1. Create an isolated test environment.
2. Apply schema and fixtures.
3. Execute deterministic SQL.
4. Capture output.
5. Compare actual output with expected output.
6. Investigate differences.
7. Update expected output only when the behavior change is intentional.

## 4. Isolation testing

Isolation tests answer questions that a single-session SQL script cannot answer:

- Can two transactions insert the same logical key?
- What does each transaction see?
- Which statement blocks?
- What happens under SERIALIZABLE?
- Does retry logic work after serialization failure?
- Does a lock order create a deadlock?

Design a test around explicit session interleavings rather than scheduler timing.

## 5. Recovery and replication tests

A production recovery test should verify:

- WAL/archive availability
- recovery target
- startup/recovery completion
- data consistency
- application reconnect behavior
- replication state
- expected RPO/RTO evidence

Never perform destructive recovery experiments against production.

## 6. Determinism rules

Avoid tests that depend on unspecified row order, uncontrolled current timestamps, random values without a controlled seed, locale-specific formatting, floating-point formatting, external services, or production state.

Use explicit ORDER BY, fixed fixtures, controlled time boundaries, and isolated databases.

## 7. Test failure taxonomy

When a test fails, classify it as:

1. Product defect
2. Test defect
3. Expected-output change
4. Environment difference
5. Dependency/configuration failure
6. Timing/concurrency flake

Never blindly regenerate expected results.

## 8. CI quality gate

create disposable PostgreSQL instance
→ apply migrations
→ load deterministic fixtures
→ run SQL regression tests
→ run concurrency/isolation tests
→ run integration tests
→ collect logs/plans/metrics
→ destroy instance

## 9. Exit criteria

A database change is ready when functional, concurrency, migration, security, performance, observability, and recovery expectations have been evaluated and the stable checks are automated.
