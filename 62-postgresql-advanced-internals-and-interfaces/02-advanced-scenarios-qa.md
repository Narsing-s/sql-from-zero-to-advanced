# Advanced PostgreSQL Internals & Interfaces — Scenario Q&A

## 1. A query becomes slower after PostgreSQL upgrade. What do you compare?
Compare EXPLAIN plans, statistics, indexes, cost settings, extensions, data distribution, and JIT behavior before and after the upgrade.

## 2. JIT is enabled but latency increased.
Compare the same workload with JIT enabled and disabled. If compilation overhead exceeds execution savings, tune thresholds or leave JIT disabled for that workload.

## 3. A prepared statement is fast for one customer and slow for another.
Check parameter skew and generic versus custom plans. Compare EXPLAIN ANALYZE behavior for representative parameter values.

## 4. pg_catalog and information_schema show different metadata.
Determine whether the question is standard metadata or PostgreSQL-specific internal detail. Validate the object state using the appropriate documented interface.

## 5. A developer wants to update pg_catalog directly.
Do not do it. Use supported SQL DDL or PostgreSQL APIs. Direct catalog manipulation can corrupt metadata.

## 6. An application cannot connect, but PostgreSQL is healthy.
Separate DNS, TCP, TLS, authentication, connection-pool, firewall, and database authorization layers. Check evidence at each boundary.

## 7. Connections suddenly take seconds before authentication.
Investigate DNS, network latency, TLS negotiation, authentication backend behavior, pool exhaustion, and server resource pressure rather than immediately changing SQL.

## 8. The application reports connection exhaustion.
Inspect pg_stat_activity, pool size, max_connections, idle-in-transaction sessions, connection lifetime, leaked connections, and transaction duration.

## 9. An FDW query fetches millions of remote rows.
Inspect EXPLAIN for predicate/join pushdown and remote SQL. Reduce unnecessary transfer and validate remote indexes/statistics.

## 10. An FDW query is fast locally but slow in production.
Compare remote network latency, remote execution plan, data volume, pushdown behavior, credentials, and remote resource pressure.

## 11. A remote filter is not pushed down.
Check whether the expression/function/operator is supported by the FDW and whether casts or local-only expressions prevent pushdown.

## 12. A TABLESAMPLE result is treated as an exact percentage.
Explain that sampling methods have statistical/physical behavior and are not equivalent to an exact WHERE predicate. Validate the intended sampling semantics.

## 13. An extension breaks after a PostgreSQL major upgrade.
Check extension compatibility, supported server versions, ABI/API expectations, migration scripts, and regression tests before restoring production rollout.

## 14. A custom extension causes server crashes.
Treat it as a server-level reliability issue. Remove it from the affected environment where safe, collect crash evidence, identify the extension boundary, and test against a supported version.

## 15. A custom scan provider produces incorrect rows.
Prioritize correctness over performance. Reproduce with a minimal query, compare against a standard plan, inspect planner/executor assumptions, and add regression coverage.

## 16. A custom table access method corrupts data.
Stop using the affected method, preserve evidence, restore/recover safely, and investigate storage-method correctness, WAL, crash recovery, concurrency, and version compatibility.

## 17. A large-object application has orphaned data.
Review the large-object lifecycle and application ownership model. Build a controlled cleanup process rather than deleting objects based only on age.

## 18. A client application has too many round trips.
Look for chatty query patterns, repeated metadata calls, unnecessary prepare/execute cycles, and opportunities for batching or pipelining.

## 19. A database is CPU-bound but queries are individually short.
Check aggregate concurrency, connection count, repeated parsing/planning, inefficient client behavior, JIT overhead, and workload amplification.

## 20. One query is fast in psql but slow through the application.
Compare parameters, prepared-statement behavior, transaction state, client driver settings, network round trips, session settings, and result-fetch behavior.

## 21. A query plan differs between psql and the application.
Compare session-level settings, role, search_path, parameters, prepared/generic plans, transaction isolation, and PostgreSQL version.

## 22. A PostgreSQL-specific query must move to another database.
Identify dialect-specific syntax/types/functions and rewrite using standard SQL where practical. Preserve semantics first; portability should not silently change results.

## 23. An application depends heavily on pg_catalog.
Inventory each catalog dependency and replace unstable/internal assumptions with documented views or application metadata APIs where possible.

## 24. A metadata query becomes slow on a large cluster.
Inspect catalog joins, predicates, permissions, statistics, and whether the query is scanning unnecessarily broad system metadata.

## 25. OAuth authentication starts rejecting all users.
Separate client token acquisition from server validation. Verify issuer/audience/expiry, validator configuration, provider availability, clock synchronization, and server logs.

## 26. OAuth accepts an invalid token.
Treat it as an authentication security incident. Restrict exposure, inspect validator configuration and implementation, preserve evidence, rotate credentials/tokens where required, and add negative tests.

## 27. TLS is enabled but credentials are still exposed in logs.
TLS does not protect credentials after they reach application/server logs. Remove sensitive logging and review log access and retention.

## 28. SCRAM authentication works locally but fails remotely.
Check pg_hba.conf rules, username/database matching, password verifier availability, TLS requirements, client library version, and network path.

## 29. A connection pool causes idle transactions.
Inspect pool transaction lifecycle. Ensure connections are returned only after COMMIT/ROLLBACK and set appropriate idle-in-transaction safeguards.

## 30. An FDW causes a local transaction to remain open for a long time.
Inspect remote latency and transaction scope. Reduce transaction duration, push work remotely where safe, and ensure failures release both local and remote resources.

## 31. A JIT regression appears only for small queries.
Compare planning and compilation overhead. JIT is not automatically beneficial for every query.

## 32. A plan regression appears after ANALYZE.
Compare old/new statistics, column distributions, extended statistics, estimates, and actual rows. Determine which estimate changed the planner decision.

## 33. A plan regression appears after adding an index.
Compare candidate plans and write overhead. An index can change planner cost choices without necessarily improving the target workload.

## 34. A database migration accidentally depends on PostgreSQL-specific syntax.
Document the dependency if PostgreSQL is the intended platform; otherwise replace it with standard SQL and add a cross-dialect compatibility test.

## 35. An application sends thousands of tiny queries.
Measure round trips and query frequency. Consolidate operations where semantics allow, use batching/prepared statements, and verify transaction boundaries.

## 36. A client reports intermittent protocol errors.
Check driver compatibility, connection reuse after errors, TLS/proxy behavior, server logs, network interruptions, and whether connections are being returned to the pool in a bad transaction state.

## 37. A custom extension works in development but fails in production.
Compare PostgreSQL major/minor version, OS/library dependencies, extension version, configuration, permissions, and installation paths.

## 38. A security review finds SECURITY DEFINER code with unqualified names.
Harden search_path, qualify sensitive objects, minimize privileges, review ownership, and add tests proving unauthorized roles cannot redirect execution.

## 39. A catalog query is used to decide whether an object exists.
Prefer supported metadata queries and account for permissions and object types. Do not infer existence solely from one internal catalog column unless that is an intentional PostgreSQL-specific design.

## 40. What is the final troubleshooting sequence for advanced PostgreSQL problems?
Reproduce → identify the layer → capture evidence → compare expected/actual behavior → isolate the smallest cause → apply the safest mitigation → validate under representative workload → add regression coverage → document the operational lesson.
