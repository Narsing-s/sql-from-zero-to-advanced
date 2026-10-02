# Stage 65 — PostgreSQL Deep Internals & Access-Method Production Scenarios

Use: **Impact → Scope → Evidence → Safe mitigation → Root cause → Permanent fix → Validation → Prevention.**

## 1. A 20-table join suddenly takes much longer to plan.
Measure planning time separately from execution time. Inspect join count, GEQO settings, statistics and plan shape. Determine whether optimizer search cost is the bottleneck before changing planner settings.

## 2. GEQO produces a slower plan after an upgrade.
Compare old/new plans, PostgreSQL versions, statistics, GEQO configuration and representative data. Test the workload with controlled planner settings to establish causality, then choose a supported configuration.

## 3. Disabling GEQO makes planning consume excessive CPU.
This indicates the join-order search itself is expensive. Compare planning-time SLOs and execution-time benefits; for very complex queries consider query decomposition or schema/query redesign rather than relying only on planner knobs.

## 4. A query has a huge estimated-vs-actual row-count mismatch.
Inspect statistics freshness, skew, correlation and multivariate relationships. Create or adjust extended statistics where justified, ANALYZE, then re-check the plan.

## 5. A multicolumn filter still gets a poor plan after ANALYZE.
Check whether the planner lacks information about column correlation. Evaluate extended statistics and confirm the resulting estimates with EXPLAIN.

## 6. UPDATE-heavy workload causes rapid index growth.
Inspect whether indexed columns change, whether HOT updates occur, page free space, fillfactor and vacuum progress. Reduce unnecessary indexed-column updates or tune storage design based on evidence.

## 7. HOT updates disappear after adding an index.
The new index may prevent HOT when the updated column is indexed. Verify tuple/index behavior and assess whether the index is necessary for the workload.

## 8. A table has many dead tuples despite frequent vacuum.
Check transaction age, long-running transactions, prepared transactions, vacuum cost/IO constraints and workload churn. Do not assume the autovacuum schedule alone explains retention.

## 9. A prepared transaction has existed for several hours.
Identify the distributed transaction owner and business operation. Determine whether it can be safely committed or rolled back. Avoid deleting database state blindly because prepared transactions may be part of a distributed commit protocol.

## 10. Prepared transactions retain locks and block DDL.
Identify the prepared transaction and blocked sessions using lock/activity views. Escalate to the transaction owner and use the documented recovery decision; prevent recurrence through transaction lifecycle monitoring.

## 11. A custom index extension returns incorrect rows.
Treat it as a correctness incident. Compare indexed and sequential results, isolate the operator class/access method, disable the unsafe path where possible and test the extension against adversarial data.

## 12. A custom index crashes during concurrent insert.
Collect server logs/core diagnostics and reproduce with multiple sessions. Audit locking and index-page modification code before redeployment.

## 13. An index extension works on PostgreSQL 17 but fails on 18.
Check the extension's supported versions and internal API changes. Rebuild/upgrade the extension using the PostgreSQL 18 development interface instead of forcing an incompatible binary.

## 14. A custom table access method corrupts pages after restart.
Stop further writes if integrity is uncertain, preserve evidence and use a known-good backup/recovery path. Investigate WAL, page layout, checksums and crash-recovery implementation before returning the access method to production.

## 15. A table access method performs well but loses data after crash.
This indicates persistence/recovery correctness is not established. Test WAL and recovery paths repeatedly under forced interruption before considering performance tuning.

## 16. Backup completes but restoration fails integrity validation.
Use the backup manifest and checksums to determine whether the backup contents are complete/correct. Do not treat a successful backup command as proof of recoverability.

## 17. Backup manifest verification detects a changed file.
Investigate whether the backup was modified, corrupted or intentionally transformed. Preserve evidence and restore from a known-good backup rather than ignoring manifest discrepancies.

## 18. Planner estimates are good for one region but poor for another.
Check data distribution and whether statistics capture the relevant correlations/skew. Increase statistics targets or create extended statistics when justified, then validate the regional query plans.

## 19. A release changes the planner's estimates but data did not change.
Compare PostgreSQL version, statistics representation, planner behavior and configuration. Treat it as a possible planner regression and benchmark critical queries before broad rollout.

## 20. A developer wants to disable all optimizer features to debug a slow query.
Use targeted planner settings only for diagnosis. Compare plans and timings, then return to normal configuration; permanent disabling of broad optimizer features can create larger regressions.

## 21. A developer wants to increase fillfactor to fix all update performance issues.
Measure HOT rate, page occupancy, index growth and table bloat first. Fillfactor is a workload-specific storage trade-off, not a universal performance switch.

## 22. A table's updates are causing excessive WAL.
Inspect whether updates are HOT, how many indexes are affected, row width changes, replication and full-page-write/checkpoint effects. Optimize the write pattern only after identifying the actual WAL source.

## 23. A query becomes slow after adding a harmless-looking index.
Compare plans before/after. The new index can change access-path choices even when the query does not explicitly reference it. Keep or remove the index based on measured workload impact.

## 24. A custom access method passes unit tests but fails under concurrency.
Add multi-session isolation tests, lock-order tests, crash/recovery tests and randomized workloads. Single-session correctness is insufficient for storage code.

## 25. A long transaction causes vacuum and storage problems.
Find the transaction, understand why it remains open, and coordinate safe termination if necessary. Prevent recurrence through application transaction boundaries and monitoring.

## 26. A subtransaction-heavy application becomes slow.
Inspect savepoint/subtransaction frequency and transaction lifetime. Reduce unnecessary nested transactional scopes and batch work appropriately.

## 27. A backup is present but cannot satisfy the recovery objective.
Check whether required WAL/archive ranges exist in addition to the base backup and whether the backup is actually restorable. Recovery readiness requires both backup integrity and the required WAL chain.

## 28. A DBA trusts row estimates without checking actual rows.
Use EXPLAIN ANALYZE carefully in production and compare estimated/actual cardinalities. Persistent mismatches should trigger statistics/data-distribution investigation.

## 29. A 40-table query is unpredictable between deployments.
Capture plans, planning time, GEQO configuration, statistics, extension versions and data distribution. Use representative query-plan regression tests for critical workloads.

## 30. An interviewer asks why PostgreSQL can be correct but still slow.
Explain that correctness comes from transactional/MVCC/storage guarantees, while performance depends on planner estimates, access paths, physical locality, statistics, I/O and workload shape. Troubleshooting requires evidence across all layers.
