# Logical Replication & CDC — 30 Production Scenarios

Use: **Impact → Scope → Evidence → Safe mitigation → Root cause → Permanent fix → Validation → Prevention.**

1. **Subscriber is 30 minutes behind.**  
Check subscription workers, apply errors, network, publisher WAL generation, locks and target-side contention before changing worker counts.

2. **A replication slot is retaining hundreds of GB of WAL.**  
Identify the slot consumer and last confirmed position. Restore consumer health or intentionally drop an obsolete slot only after confirming it is no longer required.

3. **CDC events are duplicated after a publisher restart.**  
Use source LSN/event identity for deduplication and make the downstream business operation idempotent. PostgreSQL documents that logical decoding clients may see recent changes again after crash recovery. citeturn0search8

4. **Initial table synchronization is saturating the subscriber.**  
Measure synchronization-worker concurrency, I/O, CPU, locks and network. Reduce parallelism if it harms production traffic.

5. **One large table blocks overall cutover readiness.**  
Track table synchronization separately and validate the slow table's I/O, indexes, locks and data volume rather than assuming the whole subscription is equally delayed.

6. **An UPDATE fails because the subscriber cannot identify the target row.**  
Inspect replica identity and target keys. Establish an appropriate primary/unique identity before resuming.

7. **A publication row filter excludes data expected by an application.**  
Compare publication predicates with application requirements and validate row counts by tenant/partition before cutover.

8. **A column-list change breaks the subscriber.**  
Compare publisher publication columns, subscriber schema, defaults and constraints. Roll out additive schema changes before changing the publication contract.

9. **Generated-column behavior differs between publisher and consumer.**  
Use PostgreSQL 18 generated-column publishing controls where appropriate and define explicit downstream transformation semantics. citeturn0search5

10. **Subscriber has local writes and replication conflicts.**  
Stop treating it as a passive replica. Identify conflicting writers, define ownership of each row/domain, reconcile data and establish a deliberate multi-writer strategy if required.

11. **Logical replication stops after a DDL deployment.**  
Remember that DDL is not automatically replicated. Apply compatible schema changes to the subscriber first, then resume data replication. citeturn0search4

12. **Sequence-generated IDs collide after migration.**  
Reconcile sequence state explicitly; logical replication transfers table changes, not sequence state as a replicated object. citeturn0search4

13. **A large-object application fails after logical migration.**  
Audit use of large objects because they are not logically replicated. Migrate them separately or redesign storage.

14. **Apply workers consume all worker slots.**  
Inspect logical-replication worker settings alongside parallel query and extension usage. Increase capacity only after confirming CPU/memory/connection limits.

15. **Initial synchronization creates excessive WAL/IO.**  
Measure copy throughput, concurrent synchronization, checkpoints and storage saturation. Schedule or throttle the operation based on workload SLOs.

16. **Failover publisher is promoted but CDC cannot continue.**  
Verify that the failover logical slot/state is available, that consumers have the correct source endpoint and that the replication position is consistent before resuming.

17. **Two-phase replicated transactions remain pending.**  
Identify prepared transactions and their owner. Do not arbitrarily commit/rollback them; coordinate with the distributed transaction protocol.

18. **Replication is healthy but the data warehouse has duplicates.**  
Inspect consumer retry behavior and event keys. Use an atomic inbox/watermark pattern so replay cannot duplicate business effects.

19. **CDC consumer processes an event but crashes before saving its offset.**  
Expect replay. Reprocess using an idempotent key and atomically persist the effect and source position where possible.

20. **Subscriber trigger unexpectedly does not fire.**  
Check logical-replication apply semantics and the replication session role; do not assume subscriber behavior matches an ordinary application INSERT. citeturn0search2

21. **Replication security review finds a broad subscription owner.**  
Reduce privileges to the minimum needed and review ownership/trigger implications, especially where replicated data can execute subscriber-side behavior.

22. **A publication contains too much data.**  
Use row filters and column lists where supported, then validate that the reduced dataset still satisfies keys and application requirements.

23. **Publisher upgrade requires minimal downtime.**  
Use a rehearsed logical-upgrade procedure: build target, synchronize, monitor lag, validate counts/business reconciliation, perform controlled cutover and retain rollback readiness.

24. **Subscriber upgrade breaks because extension/schema versions differ.**  
Inventory extensions and schema dependencies before cutover and validate them on the target version.

25. **Replication workers repeatedly crash.**  
Inspect server logs and subscription state, identify the failing transaction/table, reproduce safely and fix the underlying data/schema/extension issue instead of endlessly restarting workers.

26. **Logical replication lag is actually caused by target locks.**  
Correlate apply worker activity with locks, blocking sessions and long transactions. Resolve the blocker before tuning replication workers.

27. **WAL growth continues after the consumer reconnects.**  
Check whether the slot's confirmed position advances. A healthy network connection does not prove the consumer is acknowledging progress.

28. **Row-filtered replication appears correct but misses a new tenant.**  
Validate filter predicates against new tenant rows and test boundary values before enabling production traffic.

29. **A CDC downstream service cannot guarantee exactly-once delivery.**  
Design for at-least-once behavior: stable event identity, idempotent effects, durable checkpoints, replay tooling and reconciliation.

30. **Interviewer asks how you would troubleshoot logical-replication lag.**  
Start with impact and lag measurement, then inspect subscription/worker state, apply errors, blocking locks, publisher WAL generation, slot positions, network, target I/O and resource capacity. Change one variable at a time and validate recovery.
