# Stage 61 — PostgreSQL Testing & Server Programming

This stage closes an advanced PostgreSQL learning gap around database-engineering test strategy and server-side extensibility.

## Learning goals

- Understand regression testing, expected/actual output, and deterministic assertions.
- Understand pg_regress, pg_isolation_regress, TAP tests, and test-suite selection.
- Design concurrency tests for race conditions, deadlocks, serialization failures, and lock behavior.
- Design recovery, physical-replication, and logical-replication test cases.
- Understand server-side programming boundaries: PL/pgSQL, triggers, event triggers, logical decoding, background workers, and extension infrastructure.
- Understand when a feature belongs in SQL, PL/pgSQL, an extension, or an external service.
- Build production-quality database tests with setup, assertions, cleanup, isolation, and failure evidence.

## Files

- 01-regression-and-isolation-testing.md
- 02-server-programming-theory.md
- 03-testing-and-server-programming-scenarios-qa.md

## Practice checklist

1. Write deterministic SQL assertions for a feature.
2. Create a concurrency test for a race condition.
3. Reproduce and verify a deadlock safely in a disposable environment.
4. Test transaction isolation behavior.
5. Define a recovery/replication validation plan.
6. Test an extension or server-side function without changing production data.
7. Record expected behavior, evidence, root cause, and regression coverage.
