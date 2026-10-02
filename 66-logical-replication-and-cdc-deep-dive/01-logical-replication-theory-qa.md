# Logical Replication & CDC — 40 Theory Q&A

## Architecture and synchronization

1. **What is logical replication?**  
It replicates logical row changes rather than physical storage blocks, allowing selective replication and cross-version/platform use.

2. **What is a publication?**  
A publisher-side definition describing which tables and DML changes are exposed.

3. **What is a subscription?**  
A subscriber-side object that connects to a publisher and consumes a publication.

4. **What happens during initial synchronization?**  
Existing table data is copied from a snapshot, then changes that occurred during copying are synchronized before normal apply continues. citeturn0search2

5. **What processes implement logical replication?**  
The architecture uses walsender on the publisher and apply/table-synchronization workers on the subscriber. citeturn0search2

6. **Why can initial synchronization use multiple workers?**  
Each table can have a synchronization worker, allowing controlled parallelism.

7. **What is transactional ordering?**  
Changes from a publication/subscription are applied in transaction order so the subscriber can preserve transactional consistency for that subscription.

8. **What is replica identity?**  
The information used to identify the old row for UPDATE/DELETE replication.

9. **Why is a primary key useful for replica identity?**  
It provides a stable, compact row identifier for locating the target row.

10. **What is REPLICA IDENTITY FULL?**  
It allows PostgreSQL to use the full old row when no suitable key exists, with additional cost and datatype restrictions.

## Selective replication

11. **What are row filters?**  
Publication rules that restrict which rows are replicated.

12. **Why are row filters useful?**  
They can reduce replicated data and implement tenant/region/data-domain selection.

13. **What are column lists?**  
Publication rules that restrict which columns are sent for a table.

14. **What is a major design risk of column filtering?**  
The subscriber must still be able to apply the replicated change to its target schema and constraints.

15. **Can generated columns be logically replicated in PostgreSQL 18?**  
Yes; PostgreSQL 18 added support for publishing generated columns, including controls for whether generated columns are published. citeturn0search5

16. **Why does generated-column replication matter for heterogeneous CDC consumers?**  
A non-PostgreSQL consumer may not implement the same generated-expression semantics, so explicitly publishing generated values can simplify downstream consistency.

## Conflicts and correctness

17. **What is a logical replication conflict?**  
A subscriber-side condition where an incoming change cannot be applied consistently, often because of conflicting local data or constraints.

18. **Should applications write to a normally read-only subscriber?**  
Not without an explicit multi-writer/conflict architecture; independent writes can conflict with replicated changes.

19. **What should conflict handling include?**  
Detection, evidence collection, impact assessment, deterministic resolution, replay/repair and prevention.

20. **Why is idempotency important for CDC?**  
A consumer must tolerate repeated delivery or replay without producing duplicate business effects.

21. **Can a logical slot cause WAL growth?**  
Yes. If a consumer does not advance a slot, required WAL can be retained.

22. **What is a replication slot?**  
Persistent state representing a stream of changes that a consumer can replay.

23. **Can a logical decoder emit the same change twice after a crash?**  
Yes. Slot progress is checkpoint-persisted, so after a crash a client may receive recent changes again; consumers should be idempotent. citeturn0search8

24. **How should a CDC consumer deduplicate?**  
Persist a stable event/LSN or source-position watermark together with the business effect, and make processing atomic where possible.

## Failover and upgrades

25. **What is logical replication failover?**  
A design that allows logical replication state to survive publisher failure so consumers can continue from an appropriate failover slot.

26. **Why is failover more than simply restarting a subscriber?**  
The consumer needs a usable source of logical changes and a consistent replication position after publisher failure.

27. **What is two-phase commit in logical replication?**  
A subscription can be configured to handle prepared transactions so distributed commit semantics can be preserved.

28. **Why does worker capacity matter?**  
Logical replication consumes replication, apply, synchronization and parallel-apply worker resources in addition to normal workload workers. PostgreSQL documents explicit settings for these capacities. citeturn0search6

29. **How should a major-version upgrade use logical replication?**  
Build and validate the target cluster, replicate required data, reconcile differences, then coordinate cutover and rollback readiness.

30. **Does logical replication replicate DDL automatically?**  
No. Schema/DDL changes generally require explicit coordination. citeturn0search4

31. **Are sequences automatically replicated as sequence state?**  
No. Sequence state is a documented logical-replication restriction. citeturn0search4

32. **Are large objects automatically replicated?**  
No; large objects are a documented restriction. citeturn0search4

## Security and operations

33. **Why is logical replication security important?**  
Replication connects databases and can move sensitive data, so connection authentication, role privileges and subscriber execution behavior must be controlled.

34. **Why must subscription privileges be reviewed?**  
The apply process needs privileges to modify target data, and PostgreSQL documents security considerations around ownership and trigger execution.

35. **What is the role of wal_level=logical?**  
The publisher must emit WAL information sufficient for logical decoding.

36. **Why are max_replication_slots and max_wal_senders important?**  
They bound publisher replication capacity and must account for subscriptions, table synchronization and physical replicas. citeturn0search6

37. **Why are max_logical_replication_workers and max_worker_processes important?**  
Subscriber apply and synchronization consume worker resources that can otherwise be needed by extensions and parallel queries. citeturn0search6

38. **How should logical replication be monitored?**  
Monitor worker state, lag/LSN positions, subscription statistics, conflicts, slots, WAL retention and apply errors.

39. **What is the difference between logical replication and CDC?**  
Logical replication is a PostgreSQL replication mechanism; CDC is the broader pattern of consuming database changes for downstream systems such as warehouses, search or event platforms.

40. **What is the most important CDC production principle?**  
Treat delivery as potentially repeatable and design business effects to be idempotent, observable and recoverable.
