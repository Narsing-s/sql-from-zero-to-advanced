# Stage 65 — PostgreSQL Deep Internals & Access-Method Theory Q&A

This stage covers PostgreSQL 18 internals that deserve explicit treatment beyond general internals: GEQO, index-access-method interfaces, table-access-method concepts, physical storage/HOT, transaction identifiers and subtransactions, two-phase commit, backup manifests, and planner statistics internals. These topics are explicitly documented in PostgreSQL 18's Internals section. citeturn0search6turn0search11

## 1. Why does PostgreSQL need GEQO?
Join-order search grows rapidly as the number of relations increases. PostgreSQL's normal optimizer can become expensive for very large join graphs, so GEQO provides a genetic-search alternative for complex join ordering. citeturn0search8

## 2. What is a genetic query optimizer?
GEQO represents candidate join orders as a population and uses evolutionary operations such as selection, crossover/recombination and mutation to explore the search space.

## 3. Is GEQO guaranteed to find the optimal plan?
No. It is a heuristic search intended to find a good plan with bounded planning effort for complex join queries.

## 4. When can GEQO become relevant?
Primarily for queries involving many joins where exhaustive or near-exhaustive join-order exploration becomes too expensive.

## 5. Why can GEQO produce different plans between executions?
Its search is heuristic and influenced by configuration and query structure. Changes in join count, statistics, planner settings or PostgreSQL version can alter the selected plan.

## 6. What is an index access method?
It is the server interface defining how a particular index type implements operations such as scans, insertion, uniqueness checks and cost estimation. PostgreSQL documents a dedicated index access-method interface. citeturn0search6

## 7. What is an operator class in an index access method?
It defines how a data type participates in an index, including operators and support functions required by the access method.

## 8. Why do index access methods need cost-estimation support?
The planner needs estimates to compare an index path with alternatives such as sequential scans and other indexes.

## 9. What is index uniqueness checking?
An access method may participate in enforcing unique constraints by determining whether indexed keys conflict according to the index semantics.

## 10. Why does index locking matter?
Concurrent index scans and modifications must coordinate safely with transactions and structural changes. Incorrect locking in an access method can cause corruption or incorrect results.

## 11. What is a table access method?
It is an extensibility interface for alternative table-storage implementations. It abstracts table operations such as scanning, inserting and tuple visibility handling.

## 12. Why is a table access method more complex than an index?
A table access method controls fundamental storage behavior, tuple access and concurrency semantics, so correctness and crash recovery requirements are much broader.

## 13. What is a heap page?
A heap page is a fixed-size physical page containing tuple storage and page metadata. PostgreSQL organizes ordinary table data into pages.

## 14. What is a tuple header?
Tuple metadata contains information required for MVCC visibility and tuple state, including transaction-related identifiers and flags.

## 15. What is HOT?
Heap-Only Tuple (HOT) optimization can avoid creating new index entries for certain updates when indexed columns do not change and the new tuple version can remain on the same page. PostgreSQL documents HOT as part of physical storage internals. citeturn0search6

## 16. Why does HOT matter for performance?
Avoiding unnecessary index modifications can reduce write amplification and index bloat for suitable update workloads.

## 17. What prevents every update from being HOT?
Changing an indexed column, insufficient page space, or other storage conditions can prevent HOT updates.

## 18. What is a transaction ID?
PostgreSQL assigns transaction identifiers used as part of MVCC visibility and transaction state tracking.

## 19. Why is transaction-ID wraparound dangerous?
Transaction IDs have finite representation. Without freezing/maintenance, old IDs could become ambiguous for visibility, threatening database correctness.

## 20. What are subtransactions?
Subtransactions provide nested transactional scopes, commonly exposed through savepoints. They allow partial rollback within a larger transaction.

## 21. Why can excessive subtransactions hurt production systems?
Large numbers of subtransactions add transaction-management overhead and can complicate visibility and resource usage.

## 22. What is two-phase commit?
Two-phase commit coordinates a distributed transaction across participants using a prepare phase followed by commit or rollback. PostgreSQL exposes prepared transactions for this purpose.

## 23. What is the danger of forgotten prepared transactions?
They can retain locks and transaction state for long periods, preventing cleanup and potentially causing bloat or operational blockage.

## 24. What should production monitoring watch for prepared transactions?
Count and age prepared transactions, identify their owning workflows, and alert on unexpected long-lived entries.

## 25. What is a backup manifest?
A backup manifest describes files and metadata associated with a PostgreSQL base backup, enabling verification and integrity checking.

## 26. Why is a backup manifest useful?
It provides structured evidence about backup contents and checksums so operators can validate a backup rather than merely trusting that a backup command completed.

## 27. What is a planner statistic?
Planner statistics summarize data distribution so PostgreSQL can estimate row counts and selectivity.

## 28. What are multivariate statistics?
They capture relationships among columns that cannot be represented accurately by independent single-column statistics.

## 29. Why can correlated columns cause bad plans?
If the planner assumes columns are independent when they are strongly correlated, estimated row counts can be far from reality, leading to poor join or scan choices.

## 30. What is extended statistics used for?
Extended statistics can improve estimates for combinations of columns, including dependencies and distinct-value relationships.

## 31. What is a statistics-driven plan regression?
It is a performance regression caused by estimates changing enough to select a worse execution path.

## 32. Why should physical storage knowledge matter to SQL developers?
SQL behavior such as UPDATE cost, index bloat, HOT updates, vacuum and page locality is influenced by storage internals.

## 33. What is the relationship between HOT and fillfactor?
Leaving free space on pages can increase the chance that updated tuples can stay on the same page, potentially improving HOT applicability.

## 34. Can HOT eliminate all index maintenance?
No. If an indexed value changes or HOT conditions are not satisfied, index entries must be handled normally.

## 35. Why are access-method APIs version-sensitive?
They are server-internal programming interfaces. An extension compiled against one major PostgreSQL release may require changes for another.

## 36. Why must custom access methods be tested under concurrency?
Storage and index operations interact with MVCC, locking, crash recovery and concurrent modifications. Single-session tests cannot establish correctness.

## 37. Why is crash testing mandatory for storage extensions?
A storage implementation must recover consistently after interruption. Normal-path tests do not prove WAL and recovery correctness.

## 38. How should GEQO plan quality be investigated?
Capture EXPLAIN plans, planning time, execution time, join count, statistics and GEQO settings. Compare representative alternatives rather than assuming GEQO is responsible for every complex-query regression.

## 39. What is the safest approach to prepared transactions?
Use them only when the distributed transaction architecture requires them, define ownership/timeouts/cleanup procedures, and monitor their age.

## 40. What is the common lesson across PostgreSQL internals?
Planner heuristics, storage structures and transaction mechanisms exist to balance correctness, performance and operational complexity. Production troubleshooting requires evidence from all three layers.

## Interview checklist
- Explain GEQO and why join-order search becomes difficult.
- Explain index-access-method responsibilities.
- Explain table-access-method responsibilities.
- Explain HOT and its relationship to fillfactor.
- Explain XIDs and wraparound.
- Explain subtransactions and prepared transactions.
- Explain backup manifests.
- Explain multivariate planner statistics.
