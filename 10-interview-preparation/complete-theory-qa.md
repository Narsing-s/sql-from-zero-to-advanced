# Complete SQL Theory — Questions & Answers

This is the interview-ready theory companion for the curriculum. Use it after studying the corresponding stage. Answers are concise enough for interviews but include production reasoning.

## 1. SQL and relational foundations

### Q1. What is SQL?
**Answer:** SQL is a declarative language used to define, query, manipulate, and control data in relational database systems. You describe the desired result; the optimizer chooses an execution strategy.

### Q2. What is a DBMS?
**Answer:** A DBMS stores and manages data while providing querying, transactions, concurrency control, security, recovery, and administration.

### Q3. What is an RDBMS?
**Answer:** A relational DBMS organizes data into relations (tables) with rows and columns and supports relationships through keys and constraints.

### Q4. What is a schema?
**Answer:** A schema is a namespace containing database objects such as tables, views, functions, and sequences. In PostgreSQL, a database contains schemas.

### Q5. What is a primary key?
**Answer:** A primary key uniquely identifies each row and implies NOT NULL plus uniqueness. A table has one primary-key constraint, which can contain multiple columns.

### Q6. What is a foreign key?
**Answer:** A foreign key enforces a referential relationship to a candidate/primary key in another table or the same table. It prevents orphaned references unless the configured action permits them.

### Q7. What is normalization?
**Answer:** Normalization structures data to reduce unnecessary duplication and update anomalies. Common levels include 1NF, 2NF, 3NF and BCNF.

### Q8. What is denormalization?
**Answer:** Denormalization intentionally stores redundant or precomputed data to improve a measured workload, with an explicit consistency strategy.

### Q9. What is a candidate key?
**Answer:** A candidate key is a minimal set of attributes that uniquely identifies a row. One can be selected as the primary key; others can be enforced with UNIQUE.

### Q10. What is referential integrity?
**Answer:** Referential integrity ensures references between related tables remain valid according to foreign-key rules.

## 2. Query fundamentals

### Q11. What is SELECT?
**Answer:** SELECT retrieves or computes rows. The logical query-processing model includes FROM, WHERE, GROUP BY, HAVING, SELECT, DISTINCT, ORDER BY and LIMIT/OFFSET, although the optimizer can execute them differently.

### Q12. WHERE vs HAVING?
**Answer:** WHERE filters rows before grouping; HAVING filters groups after aggregation. A non-aggregate predicate generally belongs in WHERE.

### Q13. WHERE vs ON?
**Answer:** ON defines join matching. Moving a predicate from ON to WHERE can change an outer join because WHERE can remove NULL-extended rows.

### Q14. DISTINCT vs GROUP BY?
**Answer:** DISTINCT removes duplicate result rows. GROUP BY forms groups for aggregation. DISTINCT should not be used to hide an incorrect join.

### Q15. UNION vs UNION ALL?
**Answer:** UNION removes duplicates; UNION ALL preserves them and normally avoids duplicate-elimination work.

### Q16. Why is ORDER BY important?
**Answer:** SQL does not guarantee result order without ORDER BY. APIs and pagination therefore need an explicit deterministic ordering.

### Q17. LIMIT vs OFFSET?
**Answer:** LIMIT restricts rows. OFFSET skips rows but can become expensive at deep pages. Keyset/seek pagination is often more scalable.

### Q18. What is a CTE?
**Answer:** A common table expression names a subquery for one statement. It improves structure and supports recursive and data-modifying workflows. PostgreSQL can inline or materialize eligible non-recursive CTEs.

### Q19. What is a recursive CTE?
**Answer:** It contains an anchor query and a recursive member combined with UNION ALL. It is useful for trees, graphs and dependency chains. Termination and cycle handling must be designed.

### Q20. EXISTS vs IN?
**Answer:** EXISTS expresses existence and is often natural for correlated checks. IN compares against a set and has important NULL semantics. Choose based on meaning and validate the plan.

## 3. Aggregation and analytics

### Q21. What does GROUP BY do?
**Answer:** GROUP BY partitions rows into groups so aggregates such as COUNT, SUM, AVG, MIN and MAX can return one result per group.

### Q22. COUNT(*) vs COUNT(column)?
**Answer:** COUNT(*) counts rows. COUNT(column) counts only rows where the expression is non-null.

### Q23. GROUP BY vs window function?
**Answer:** GROUP BY collapses rows to one result per group. Window functions calculate across related rows while retaining row-level detail.

### Q24. ROW_NUMBER vs RANK vs DENSE_RANK?
**Answer:** ROW_NUMBER gives every row a unique sequence. RANK leaves gaps after ties. DENSE_RANK does not leave gaps after ties.

### Q25. What is a window frame?
**Answer:** A window frame defines which rows around the current row participate in a window calculation. ROWS and RANGE can behave differently when ordering values tie.

### Q26. What are GROUPING SETS, ROLLUP and CUBE?
**Answer:** They calculate multiple grouping levels in one statement. ROLLUP produces hierarchical subtotals; CUBE produces combinations of dimensions.

### Q27. What is FILTER on an aggregate?
**Answer:** FILTER restricts the rows seen by one aggregate, allowing multiple conditional aggregates without changing the input row set for other expressions.

### Q28. How do you find duplicates?
**Answer:** Group by the business key and use HAVING COUNT(*) > 1. Then determine whether duplicates are valid or data-quality defects before changing data.

### Q29. How do you find the second-highest value?
**Answer:** Use DENSE_RANK for a tie-aware definition, or a distinct ordered approach when the requirement explicitly defines the semantics.

### Q30. What is a percentile?
**Answer:** A percentile identifies a value below which a specified percentage of observations falls. PostgreSQL supports ordered-set aggregates such as percentile_cont and percentile_disc.

## 4. NULL, data types and expressions

### Q31. What is NULL?
**Answer:** NULL represents an unknown or missing value, not zero or an empty string. Predicates involving NULL use three-valued logic.

### Q32. Why is column = NULL wrong?
**Answer:** NULL is not equal to anything, including another NULL. Use IS NULL or IS NOT NULL.

### Q33. What is three-valued logic?
**Answer:** SQL predicates can evaluate to TRUE, FALSE or UNKNOWN. WHERE retains only TRUE rows, which explains many NULL-related surprises.

### Q34. COALESCE vs NULLIF?
**Answer:** COALESCE returns the first non-null expression. NULLIF returns NULL when two expressions are equal and is useful for normalizing sentinel values or preventing divide-by-zero.

### Q35. DATE vs TIMESTAMP vs TIMESTAMPTZ?
**Answer:** DATE stores a calendar date. TIMESTAMP has no time-zone semantics. TIMESTAMPTZ represents an instant and displays it using the session time zone.

### Q36. Why use NUMERIC for money?
**Answer:** NUMERIC provides exact decimal arithmetic, avoiding binary floating-point rounding surprises. Currency scale, rounding and currency identity should still be explicitly designed.

### Q37. What is an ENUM?
**Answer:** ENUM defines a fixed ordered set of labels. It is useful for stable small domains but can be less flexible than a lookup table when values change frequently.

### Q38. What is a domain?
**Answer:** A domain is a reusable type plus constraints, useful when the same validation rule applies to many columns.

## 5. Transactions and concurrency

### Q39. What are ACID properties?
**Answer:** Atomicity makes a transaction all-or-nothing; consistency preserves invariants; isolation controls concurrent visibility; durability makes committed changes survive according to configured durability guarantees.

### Q40. What is MVCC?
**Answer:** PostgreSQL uses multiversion concurrency control so readers can use appropriate row versions while writers create new versions. This reduces read/write blocking but produces dead tuples that require vacuum.

### Q41. What is READ COMMITTED?
**Answer:** It is PostgreSQL's default isolation level. Each statement gets its own snapshot, so two statements in one transaction can see different committed data.

### Q42. What is REPEATABLE READ?
**Answer:** A transaction uses a stable snapshot for its reads. Concurrent conflicts can cause transaction failure when the requested result cannot safely be represented.

### Q43. What is SERIALIZABLE?
**Answer:** SERIALIZABLE detects dangerous concurrent patterns and aborts transactions that cannot be represented as a serial execution. Applications must retry appropriate serialization failures.

### Q44. What causes a deadlock?
**Answer:** Transactions hold locks needed by each other, forming a cycle. PostgreSQL detects the cycle and aborts one transaction.

### Q45. How do you prevent deadlocks?
**Answer:** Acquire resources in a consistent order, keep transactions short, avoid unnecessary locks, index relevant foreign keys, and retry safe transient failures.

### Q46. What is an advisory lock?
**Answer:** It is an application-defined lock identified by a key. PostgreSQL does not automatically associate it with table rows, so every cooperating application must follow the same convention.

## 6. Indexes and performance

### Q47. What is an index?
**Answer:** An index is an auxiliary structure that can reduce lookup work. It consumes storage and adds write and maintenance overhead.

### Q48. Why might PostgreSQL ignore an index?
**Answer:** A sequential scan may be cheaper when many rows qualify, the table is small, statistics are stale, the predicate is not index-friendly, or planner estimates are wrong.

### Q49. What is a composite index?
**Answer:** It indexes multiple columns in a defined order. Column order affects which predicates, joins and ORDER BY operations can efficiently use it.

### Q50. What is EXPLAIN ANALYZE?
**Answer:** EXPLAIN shows a planned execution strategy. EXPLAIN ANALYZE executes the statement and reports actual row counts and timing, so it must be used carefully with writes and expensive queries.

### Q51. What is selectivity?
**Answer:** Selectivity describes how strongly a predicate reduces rows. Highly selective predicates often benefit more from indexes.

### Q52. What is ANALYZE?
**Answer:** ANALYZE collects table statistics used by the planner to estimate row distributions and choose plans.

### Q53. What is VACUUM?
**Answer:** VACUUM processes dead tuples, updates visibility information and helps prevent transaction ID wraparound. VACUUM FULL rewrites the table and requires stronger locking.

## 7. PostgreSQL internals, recovery and replication

### Q54. What is WAL?
**Answer:** Write-ahead logging records changes before data pages are considered durable. WAL enables crash recovery and replication.

### Q55. What is a checkpoint?
**Answer:** A checkpoint establishes a recovery point by writing required dirty buffers. Tuning balances recovery time, write pressure and latency.

### Q56. What is a replication slot?
**Answer:** A replication slot retains WAL or logical changes until a consumer advances. A stalled slot can cause substantial WAL growth.

### Q57. Streaming vs logical replication?
**Answer:** Physical streaming replication transfers physical changes for a standby cluster. Logical replication publishes logical row changes and allows selective table-level replication.

### Q58. What is PITR?
**Answer:** Point-in-time recovery restores a base backup and replays archived WAL until a selected recovery target.

### Q59. What are RPO and RTO?
**Answer:** RPO is the maximum acceptable data-loss window. RTO is the maximum acceptable recovery-time window. Architecture must be tested against both.

### Q60. What is partition pruning?
**Answer:** Partition pruning avoids partitions that cannot contain qualifying rows. Queries need predicates compatible with the partition key for effective pruning.

## 8. Security and production engineering

### Q61. Authentication vs authorization?
**Answer:** Authentication establishes identity. Authorization determines permitted actions.

### Q62. What are GRANT and REVOKE?
**Answer:** GRANT assigns object privileges and REVOKE removes them. Least privilege should be the default.

### Q63. What is RLS?
**Answer:** Row-Level Security applies policies that control row visibility and modification for roles. It is an enforcement layer, not a complete application authorization architecture.

### Q64. SECURITY DEFINER vs INVOKER?
**Answer:** SECURITY DEFINER executes with the function owner's privileges; INVOKER uses the caller's privileges. SECURITY DEFINER code requires careful search_path and object-resolution controls.

### Q65. How do you prevent SQL injection?
**Answer:** Parameterize values, avoid concatenating untrusted input into SQL, safely quote identifiers, validate allowed identifiers, and use least-privileged roles.

### Q66. What is UPSERT?
**Answer:** PostgreSQL's INSERT ... ON CONFLICT provides atomic conflict handling based on a unique/exclusion constraint and is useful for idempotent ingestion.

### Q67. What is MERGE?
**Answer:** MERGE conditionally performs INSERT, UPDATE or DELETE based on source/target matching. Concurrency and conflict semantics must be understood for the workload.

### Q68. What is JSONB?
**Answer:** JSONB stores JSON in a decomposed representation suited to indexing and querying. Stable, frequently filtered attributes may be better modeled relationally.

### Q69. What are range types?
**Answer:** Range types represent intervals such as date or timestamp ranges and support containment/overlap operations with appropriate indexes.

### Q70. What makes a strong SQL interview answer?
**Answer:** Define the concept, explain why it matters, show a minimal example, mention edge cases, discuss correctness/performance, and explain how you would validate it in production.

## 9. PostgreSQL 18 interview topics

### Q71. What is new in PostgreSQL 18?
**Answer:** Major additions include asynchronous I/O, retained optimizer statistics during pg_upgrade, B-tree skip scans, uuidv7(), virtual generated columns, OAuth authentication, OLD/NEW in DML RETURNING, and temporal constraints.

### Q72. What are temporal constraints?
**Answer:** PostgreSQL 18 supports temporal constraints such as WITHOUT OVERLAPS on primary/unique constraints and PERIOD foreign keys for temporal referential integrity.

### Q73. What are OLD and NEW in RETURNING?
**Answer:** PostgreSQL 18 permits OLD and NEW row values in DML RETURNING, making before/after values directly available for INSERT, UPDATE, DELETE and MERGE.

### Q74. What is UUIDv7?
**Answer:** uuidv7() generates time-ordered UUID values. Their ordering characteristics can improve locality compared with random UUIDs in some workloads.

### Q75. What are virtual generated columns?
**Answer:** Virtual generated columns compute their values when read rather than storing the generated value, trading storage for read-time computation.

### Q76. What is PostgreSQL 18 AIO?
**Answer:** PostgreSQL 18 introduces asynchronous I/O intended to improve I/O-heavy operations including sequential scans, bitmap heap scans and vacuum.

### Q77. Why must PostgreSQL version-specific answers include the version?
**Answer:** SQL behavior and features evolve. A correct PostgreSQL 18 answer may not apply to older versions, so production and interview answers should state the version when behavior differs.

## 10. Data engineering and operations

### Q78. What is CDC?
**Answer:** Change data capture records inserts, updates and deletes so downstream systems can consume changes incrementally.

### Q79. What is idempotency?
**Answer:** An operation is idempotent when repeating the same logical request produces the same intended final state. Unique keys, idempotency keys and atomic upserts are common techniques.

### Q80. What is SCD Type 2?
**Answer:** Slowly Changing Dimension Type 2 preserves historical versions using effective intervals or equivalent version metadata.

### Q81. How do you investigate a slow query?
**Answer:** Capture exact SQL and parameters, inspect EXPLAIN ANALYZE safely, compare estimated and actual rows, inspect indexes/statistics/I/O/locks, change one thing at a time, and validate latency and resource usage.

### Q82. How do you investigate connection exhaustion?
**Answer:** Inspect pg_stat_activity, pool sizing, active/idle-in-transaction sessions, connection limits and transaction age. Fix leaks or pool behavior before blindly increasing limits.

### Q83. How do you investigate blocking?
**Answer:** Identify blocked and blocking PIDs, wait events, lock modes, transaction age and business ownership. Mitigate safely and correct the transaction/locking design.

### Q84. How should a production SQL change be deployed?
**Answer:** Review dependencies and lock impact, test with representative data, make the change backward-compatible where possible, define rollback/forward-fix strategy, monitor execution, and validate the final state.

### Q85. What is the difference between a symptom and root cause?
**Answer:** A symptom is the observed failure, such as high latency. Root cause is the mechanism producing it, such as an inaccurate plan caused by stale statistics. Never declare root cause from symptoms alone.
