# Testing & Server Programming — Scenario Q&A

## 1. A query works manually but breaks after a schema change. What do you do?
Create a deterministic regression test reproducing the old expected behavior, run it against the changed schema, inspect the failure, and determine whether the schema change intentionally altered the contract.

## 2. Two transactions intermittently create duplicate business records. How do you test it?
Use an isolation/concurrency test that starts both transactions against the same logical key. Assert the intended constraint or serialization behavior and verify safe retry handling.

## 3. A regression test fails only on one machine. What is your first step?
Compare actual and expected output. Check row ordering, locale, date/time formatting, floating-point representation, configuration, and PostgreSQL version before treating it as a product defect.

## 4. A test is flaky because two sessions race.
Move it to an explicit isolation/concurrency test. Define the intended interleaving and synchronization points instead of relying on scheduler timing.

## 5. A SERIALIZABLE transaction sometimes fails with a serialization error. Is that automatically a bug?
No. Serialization failures can be an expected concurrency outcome. Verify that the application rolls back the failed transaction and retries safely.

## 6. How would you test deadlock handling?
Use a disposable database, create two transactions with intentionally reversed lock order, verify deadlock detection, and assert that cleanup completes.

## 7. How would you test a migration that adds NOT NULL to a large table?
Test production-like volume and concurrency. Measure lock duration, query impact, deployment time, rollback strategy, and validation. Prefer expand/validate/contract when an immediate blocking operation is unsafe.

## 8. A trigger unexpectedly slows bulk INSERTs. How do you investigate?
Measure trigger execution cost, identify extra queries, compare bulk-load behavior in a test environment, and determine whether the invariant can be enforced more efficiently.

## 9. A trigger recursively invokes itself.
Inspect trigger conditions and the write path. Add explicit guards or redesign the state transition. Add a regression test proving recursion cannot continue indefinitely.

## 10. A SECURITY DEFINER function is vulnerable to object shadowing. What is the concern?
An unsafe search_path can cause object references to resolve to attacker-controlled objects. Harden the function with a controlled search path and explicitly qualified objects, then add an authorization regression test.

## 11. When should logic move from a trigger to the application?
When the behavior is workflow-oriented, requires external services, is difficult to reason about transactionally, or creates unacceptable hidden side effects.

## 12. When should logic stay in the database?
When correctness depends on a transaction boundary shared by multiple clients, such as uniqueness, referential integrity, or a small atomic state transition.

## 13. A logical-decoding consumer restarts and reprocesses an event. What do you test?
Test duplicate delivery explicitly. Use an idempotency key or durable consumer position and verify that reprocessing does not create duplicate business effects.

## 14. A replication slot causes WAL growth.
Inspect slot state and consumer progress. Confirm whether the consumer is stalled or abandoned, measure retained WAL, and establish safe operational handling.

## 15. How do you test crash recovery?
Use a disposable instance and controlled failure injection. Verify startup recovery, WAL replay, consistency, expected durability, and application reconnect behavior.

## 16. How do you test logical replication?
Create source and subscriber test instances, verify initial synchronization, incremental changes, failure/reconnect behavior, and duplicate/retry semantics.

## 17. A database test depends on current time and fails around midnight.
Replace uncontrolled current-time assertions with fixed test data or a controlled time boundary.

## 18. Why should SELECT tests use ORDER BY when order matters?
SQL does not guarantee a meaningful row order without an ordering requirement. Add explicit ORDER BY for deterministic output.

## 19. A test passes locally but not in CI because of locale.
Normalize the expected representation or configure the test environment consistently, depending on what behavior the test is intended to verify.

## 20. How do you test an extension upgrade?
Install version N, create representative objects/data, upgrade to N+1, verify object definitions and behavior, then run compatibility and regression tests.

## 21. When is an extension preferable to copying SQL scripts into every database?
When the functionality is reusable, versioned, installable, upgradeable, and has a clear ownership boundary.

## 22. How do you test a PostgreSQL extension?
Test installation, upgrade, uninstall behavior where supported, permissions, dependencies, SQL objects, server-version compatibility, and failure paths.

## 23. A custom archive module reports success before durable storage is guaranteed. Why is this dangerous?
The server may treat WAL as safely archived when it is not. Archive success must represent the durability contract required for recovery.

## 24. A custom OAuth validator accepts malformed tokens. What is the severity?
It is an authentication boundary failure. Stop rollout, restrict access as appropriate, inspect validator logic and configuration, and add negative authentication tests.

## 25. How would you test an OAuth validator without a real provider?
Use a dedicated test provider or mock with deterministic valid, expired, wrong-issuer, wrong-audience, malformed, revoked, and insufficient-scope tokens. Never use production bearer tokens.

## 26. A background worker consumes database state twice.
Define an explicit ownership/locking protocol, make processing idempotent, and test concurrent workers.

## 27. A DDL audit event trigger misses expected records.
Check event type, timing, transaction behavior, permissions, disabled triggers, and operation scope. Add a DDL regression matrix.

## 28. How do you distinguish a test defect from a product defect?
Reproduce independently, verify the expected behavior against the contract, minimize the test, compare versions/configuration, and determine whether the assumption or product behavior is wrong.

## 29. A production query became slower after an index was added.
Compare plans, statistics, table distribution, cache state, write overhead, and planner estimates. Add a performance regression test.

## 30. What should every production database test report after failure?
Impact, scope, exact failure, environment/version, evidence, expected vs actual behavior, reproduction steps, suspected cause, mitigation, permanent fix, and regression coverage.

## 31. How would you test a connection-pool configuration?
Generate realistic concurrency, verify pool limits, database connection limits, transaction duration, timeout behavior, connection reuse, and cleanup.

## 32. A test hangs instead of failing.
Apply bounded timeouts, inspect locks/activity, capture logs and active queries, identify the blocking dependency, and make the test fail with actionable diagnostics.

## 33. How do you test RLS?
Test allowed rows, denied rows, bypass roles, INSERT/UPDATE/DELETE policies, policy interactions, and tenant isolation.

## 34. How do you test SQL injection defenses?
Use parameterized queries and negative test inputs containing quotes, comments, operators, and unexpected identifiers. Verify that input remains data.

## 35. How do you test a stored procedure that partially fails?
Run it in a controlled transaction, verify atomicity or documented partial-commit behavior, inspect exception handling, and confirm cleanup.

## 36. How do you test retry logic?
Inject retryable errors, verify rollback before retry, enforce bounded retries/backoff, and assert idempotent business outcomes.

## 37. How do you test timeout behavior?
Use controlled long-running queries or locks in a disposable environment. Verify statement timeout, lock timeout, application timeout, rollback, and connection reuse.

## 38. A performance test shows high variance.
Check cache state, background activity, autovacuum, statistics, CPU contention, I/O, parallelism, and test isolation. Repeat enough times to separate systematic regression from environmental noise.

## 39. How do you test partition pruning?
Create representative partitions, inspect EXPLAIN plans, test matching and nonmatching partition keys, and verify parameterized behavior.

## 40. What is the strongest answer structure for a database incident interview?
Impact → Scope → Evidence → Hypothesis → Safe mitigation → Root cause → Permanent fix → Validation → Prevention → Regression test.

## 41. How do you test a new database feature before release?
Define functional, concurrency, security, migration, performance, observability, and recovery acceptance criteria. Automate stable checks against the supported PostgreSQL version.

## 42. Why are regression tests valuable for database migrations?
They turn a migration from a one-time manual action into a repeatable contract and detect accidental behavioral drift.

## 43. What is a good database-test fixture?
Small, deterministic, representative, isolated, easy to reset, and focused on the behavior being tested.

## 44. How do you prevent test data leakage between cases?
Use isolated databases/schemas or transactional cleanup, unique identifiers, explicit teardown, and CI jobs that do not share mutable state.

## 45. How do you test a CDC pipeline end to end?
Write source changes, capture the logical change, consume it, apply the downstream effect, verify ordering/idempotency, inject a consumer restart, and verify recovery without duplicate business effects.

## 46. What should be checked after a PostgreSQL version upgrade?
Extension compatibility, SQL behavior, query plans, authentication, replication, backup/restore, monitoring, application drivers, migrations, and critical regression suites.

## 47. Why should expected regression output be reviewed?
Updating expected output can hide a real defect. A changed output is evidence that behavior changed and must be explained.

## 48. How do you make a database CI pipeline safe?
Use disposable databases, least-privilege credentials, isolated networks, deterministic fixtures, bounded resource usage, cleanup, artifact collection, and no production credentials.

## 49. What is the difference between functional and concurrency testing?
Functional testing checks sequential behavior. Concurrency testing checks behavior when multiple transactions/processes interact and timing or locking affects results.

## 50. What is the final proof that a production fix is complete?
The root cause is understood, the fix is validated, the affected workload behaves correctly, operational metrics are healthy, and a regression test prevents recurrence.
