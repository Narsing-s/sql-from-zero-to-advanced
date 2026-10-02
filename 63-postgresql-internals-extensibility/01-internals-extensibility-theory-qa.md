# Advanced PostgreSQL Internals, Rewrite System, Extensibility & Failure Semantics — Theory Q&A

This chapter closes the remaining deep PostgreSQL theory gaps that are easy to miss in a SQL curriculum: query rewrite rules, parser/analyzer/planner/executor internals, memory contexts and snapshots, WAL/checkpoint internals, extension WAL, procedural-language handlers, custom data types, FDW architecture, logical-replication failover, MERGE semantics, and safe extensibility.

> Target: PostgreSQL 18.x. Verify version-specific behavior before using production examples.

## 1. What is the PostgreSQL query lifecycle?
A client request is parsed, transformed/analyzed, rewritten, planned, and executed. The executor produces rows or command results and sends protocol messages back to the client.

## 2. What does the parser produce?
The raw parser converts SQL text into a parse tree representing the syntactic structure. It has not yet resolved every relation, column, type, or operator to catalog objects.

## 3. What happens during parse analysis?
The analyzer resolves names, types, operators, functions, relations, and permissions needed to turn the raw parse tree into a semantically meaningful query representation.

## 4. Where does the rule system fit?
Query rewrite happens after analysis and before planning. Rules can transform a query tree, especially for views and explicitly defined rules.

## 5. How are rules different from triggers?
Rules rewrite queries before planning; triggers execute as part of DML execution. A rule can cause additional query actions, while a trigger operates on rows or statements during execution.

## 6. Why can rules be surprising?
One user statement can be rewritten into multiple actions, and command-result behavior and privileges can differ from what a simple trigger-based mental model suggests. Prefer the simpler mechanism when a trigger or application logic expresses the requirement clearly.

## 7. What is the planner's job?
The planner chooses an execution strategy from possible paths using statistics, costs, indexes, join strategies, parallelism, partition pruning, and other information.

## 8. What is the executor's job?
The executor runs the selected plan nodes and produces the requested result or data modification effects.

## 9. What are plan nodes?
Plan nodes are executable operators such as Seq Scan, Index Scan, Bitmap Heap Scan, Sort, Hash Join, Merge Join, Nested Loop, Aggregate, Gather, and ModifyTable.

## 10. Why can the same SQL have different plans?
Statistics, parameter values, relation size, configuration, available indexes, cache state, parallelism, and PostgreSQL version can change cost estimates and therefore plan selection.

## 11. What is a generic prepared plan?
A generic plan is reusable across executions and does not specialize the plan for a particular parameter value. It can reduce planning overhead but may perform poorly with highly skewed parameter distributions.

## 12. What is a custom prepared plan?
A custom plan is planned with the current parameter values in mind. It can be better for skewed workloads but costs more planning work.

## 13. What are memory contexts?
PostgreSQL groups allocations into memory contexts so related allocations can be released together. This helps control lifetime and cleanup of memory used by server operations.

## 14. Why are memory contexts important in extension development?
An extension that allocates memory in the wrong context can create leaks, premature frees, or unexpected lifetime behavior. Extension code must understand the context in which returned or cached objects live.

## 15. What is a snapshot?
A transaction snapshot represents which transaction changes are visible to a statement or transaction under PostgreSQL's MVCC model.

## 16. Why is MVCC visibility not just a boolean row flag?
Visibility depends on transaction IDs, commit status, snapshot boundaries, tuple metadata, and transaction state. The same physical tuple can be visible to one transaction and invisible to another.

## 17. What is an XID wraparound problem?
Transaction IDs are finite-width identifiers. If old transaction IDs are not frozen/managed, visibility semantics can eventually become unsafe. Autovacuum and freezing are therefore correctness mechanisms, not merely performance features.

## 18. What is the visibility map?
The visibility map tracks page-level properties such as whether all tuples on a page are visible to all transactions and whether a page needs vacuuming. It supports vacuum efficiency and can enable index-only scans when other conditions are satisfied.

## 19. What is the free space map?
The free space map records approximate free space available on table pages so PostgreSQL can find pages suitable for new tuple versions.

## 20. What is TOAST?
TOAST stores oversized variable-length values out of line or compressed so ordinary heap pages can remain within page-size constraints.

## 21. What is WAL's core purpose?
Write-ahead logging records durable change information before corresponding data pages are considered safely written. Recovery replays WAL to reconstruct a consistent state after a crash.

## 22. What does wal_level control?
It controls how much information PostgreSQL writes to WAL. PostgreSQL 18 documents minimal, replica, and logical levels, with higher levels supporting more recovery/replication features. citeturn0search16

## 23. What is a checkpoint?
A checkpoint establishes a recovery point by ensuring required dirty data pages are flushed and recording checkpoint state in WAL. It limits how much WAL normally needs replay after a crash.

## 24. Why can checkpoints hurt performance?
Aggressive checkpoint activity can increase write I/O and create bursts. Checkpoint tuning must consider workload, storage, WAL generation, and recovery objectives rather than using one universal value.

## 25. What is crash recovery?
After an unclean shutdown, PostgreSQL replays required WAL from the recovery point to bring data pages to a transactionally consistent state.

## 26. What is WAL archiving?
Archiving copies completed WAL segments to durable storage so they can be used for point-in-time recovery and other recovery workflows.

## 27. What is a custom WAL resource manager?
Extensions that implement storage/access behavior may need their own WAL record handling. PostgreSQL documents generic WAL records and custom resource managers for crash-safe extensions. citeturn0search14

## 28. Why does WAL design matter to an extension?
An extension that modifies persistent state must ensure crash recovery can reproduce or safely handle those changes. Incorrect WAL integration can turn a successful-looking operation into a recovery corruption risk.

## 29. What is PostgreSQL's extensibility model?
PostgreSQL is strongly catalog-driven: catalogs describe types, functions, operators, access methods, and other database objects. This architecture allows substantial extension without changing the core server for every feature. citeturn0search17

## 30. What is a procedural-language handler?
A handler connects PostgreSQL to a procedural language implementation. PostgreSQL documents handler, optional inline handler, and validator concepts for procedural languages. citeturn0search15

## 31. Which procedural languages are in the standard PostgreSQL distribution?
PostgreSQL 18 documents PL/pgSQL, PL/Tcl, PL/Perl, and PL/Python as the standard distribution's procedural languages. citeturn0search6

## 32. What is a validator function?
A validator can inspect a function definition when it is created or replaced and reject invalid or unsafe definitions for a procedural language.

## 33. What is SPI?
The Server Programming Interface lets server-side code and extensions execute SQL through PostgreSQL's internal interfaces rather than pretending to be an external client.

## 34. Why must SPI code be careful with memory contexts?
SPI operations can create temporary objects and switch contexts. Extension code must retain values in an appropriate longer-lived context if it needs them after the current operation.

## 35. What is an FDW?
A Foreign Data Wrapper lets PostgreSQL access foreign data sources through a defined server-side interface.

## 36. What is predicate pushdown in FDWs?
The FDW can execute supported filters or projections remotely, reducing rows and data transferred to PostgreSQL. Pushdown is valuable only when the remote semantics and cost make it safe and beneficial.

## 37. What is TABLESAMPLE?
TABLESAMPLE provides a standardized mechanism to request a sample of table rows using a sampling method. Sampling can be useful for approximate analysis, profiling, and test data inspection.

## 38. Why can a custom scan provider be dangerous?
A custom scan provider changes execution behavior. Bugs can cause wrong results, crashes, or severe performance regressions, so correctness testing must be stronger than ordinary SQL testing.

## 39. What is a table access method?
It is an extensibility interface for alternative table storage/access implementations. It is substantially deeper than creating an ordinary index or SQL function.

## 40. What is a custom data type?
PostgreSQL can be extended with user-defined types, including associated input/output and other functions. A custom type must define consistent semantics for comparison, storage, and SQL interaction.

## 41. Why are operator semantics important for custom types?
Planner behavior, indexes, equality, ordering, hashing, and joins depend on consistent operator and support-function semantics. Incorrect definitions can produce incorrect query results, not merely slower plans.

## 42. What is logical decoding?
Logical decoding turns WAL changes into a logical change stream, which can feed logical replication or change-data-capture systems.

## 43. What is the logical replication architecture?
PostgreSQL uses WAL decoding and a replication protocol to transfer changes from publisher-side processes to subscriber apply workers. citeturn0search5

## 44. What is logical replication failover in PostgreSQL 18?
Logical replication slots can be synchronized to a physical standby so subscriptions can continue after the standby is promoted, provided the required slot synchronization and ordering conditions are satisfied. citeturn0search0

## 45. What is the key risk during logical replication failover?
A promoted standby must have the relevant logical slots synchronized far enough for subscribers to continue safely. An operator should verify slot state and standby/subscriber ordering rather than assuming physical promotion automatically preserves logical replication.

## 46. What is MERGE?
MERGE conditionally inserts, updates, or deletes target rows based on a source-to-target match. PostgreSQL 18 supports MATCHED, NOT MATCHED BY SOURCE, NOT MATCHED/BY TARGET, ordered WHEN clauses, and RETURNING. citeturn0search2

## 47. What is important about MERGE WHEN ordering?
For each candidate change row, PostgreSQL evaluates WHEN clauses in order and executes the first matching clause. Therefore, broad clauses placed before narrow clauses can change behavior. citeturn0search2

## 48. What is merge_action()?
PostgreSQL 18 provides merge_action() for MERGE RETURNING so the result can identify whether a row was INSERTed, UPDATEd, or DELETEd. citeturn0search7

## 49. Why must SQL portability be tested rather than assumed?
SQL standards define common semantics, but database products differ in syntax, data types, functions, optimizer behavior, locking, and extensions. A portable design should isolate vendor-specific features and test behavior on each target engine.

## 50. What is the safest approach to PostgreSQL extensibility?
Treat extensions as production software: define compatibility/version policy, test upgrade and downgrade assumptions, validate crash recovery, control privileges, test concurrency, observe memory/resource use, and document supported PostgreSQL versions.

## Interview checklist
- Explain parser → analyzer → rewrite → planner → executor.
- Explain rules versus triggers.
- Explain MVCC snapshots, XID freezing, VM, FSM, and TOAST.
- Explain WAL, checkpoints, archiving, and crash recovery.
- Explain extension WAL and why persistence must be crash-safe.
- Explain procedural language handlers and validators.
- Explain FDW pushdown and custom scan risks.
- Explain custom data types and operator/index semantics.
- Explain logical replication failover and slot synchronization.
- Explain PostgreSQL 18 MERGE ordering and merge_action().
