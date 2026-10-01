# SQL Core Concepts — Complete Theory Reference

This guide defines the essential SQL vocabulary and concepts before advanced SQL.

## 1. Database
A database is an organized collection of data managed by a database management system (DBMS).

**Why:** It provides controlled storage, querying, integrity, security, concurrency and recovery.

## 2. DBMS
A Database Management System is software that stores and manages databases.

Examples include PostgreSQL, MySQL, SQL Server and Oracle.

## 3. RDBMS
A Relational Database Management System stores related data using relational structures, commonly tables.

## 4. Schema
A schema is a namespace/container for database objects such as tables, views, functions and sequences.

## 5. Table
A table stores rows described by columns.

## 6. Row / Record
A row is one occurrence of an entity represented by a table.

## 7. Column / Attribute
A column describes one property of the rows in a table.

## 8. Data Type
A data type defines what kind of value a column can store.

Examples: integer, numeric, text, date, timestamp, boolean, UUID and JSONB.

## 9. Domain
A domain is the set of valid values a data item can have.

A database column's type and constraints help define its domain.

## 10. Entity
An entity is a real-world thing represented in a database, such as Customer or Account.

## 11. Relationship
A relationship describes how entities are connected.

Examples: customer owns account; order contains product.

## 12. Cardinality
Cardinality describes how many records can participate in a relationship.

Common forms: one-to-one, one-to-many and many-to-many.

## 13. Primary Key
A primary key uniquely identifies each row.

It must be unique and non-null.

## 14. Candidate Key
A candidate key is a minimal set of columns capable of uniquely identifying a row.

One candidate key can be selected as the primary key.

## 15. Natural Key
A natural key uses meaningful business data as an identifier, such as a government-issued or externally assigned identifier.

## 16. Surrogate Key
A surrogate key is an artificial identifier created for database identity, commonly an integer or UUID.

## 17. Foreign Key
A foreign key references a key in another table and represents a referential relationship.

## 18. Referential Integrity
Referential integrity means references between related tables remain valid according to foreign-key rules.

## 19. UNIQUE Constraint
UNIQUE prevents duplicate non-null key values according to the database's uniqueness semantics.

## 20. NOT NULL
NOT NULL requires a value to be present.

## 21. CHECK Constraint
CHECK requires a row to satisfy a Boolean condition.

Example:

```sql
CHECK (amount >= 0)
```

## 22. DEFAULT
A DEFAULT supplies a value when an INSERT does not provide one.

## 23. Constraint
A constraint is a database rule that restricts invalid data.

## 24. Index
An index is an auxiliary data structure that can make certain searches and ordering operations faster.

Indexes consume storage and add write/maintenance cost.

## 25. Sequence
A sequence generates ordered numeric values independently of table rows.

## 26. Identity Column
An identity column automatically obtains values from an internally managed sequence mechanism.

## 27. View
A view is a stored query definition exposed like a table.

## 28. Materialized View
A materialized view stores the result of a query and requires refreshing to reflect later source changes.

## 29. Function
A function is reusable database logic that returns a value or result.

## 30. Procedure
A procedure is callable database-side logic designed for operations rather than the function-return model.

## 31. Trigger
A trigger causes database-side logic to run automatically when configured events occur.

## 32. Transaction
A transaction is a logical unit of database work that can be committed or rolled back.

## 33. COMMIT
COMMIT makes the transaction's changes permanent according to database durability semantics.

## 34. ROLLBACK
ROLLBACK discards uncommitted changes in the current transaction.

## 35. SAVEPOINT
A savepoint creates a point inside a transaction to which work can be rolled back without discarding the entire transaction.

## 36. ACID
ACID means Atomicity, Consistency, Isolation and Durability.

## 37. Atomicity
A transaction's logical work is treated as an all-or-nothing unit.

## 38. Consistency
A successful transaction preserves the database's defined integrity rules.

## 39. Isolation
Isolation controls how concurrent transactions interact and observe each other's work.

## 40. Durability
Durability means committed changes are protected against the failures covered by the database's durability design.

## 41. NULL
NULL represents an unknown, missing or inapplicable value. It is not the same as zero, false or an empty string.

## 42. Three-Valued Logic
SQL Boolean expressions can produce TRUE, FALSE or UNKNOWN because of NULL.

## 43. SELECT
SELECT retrieves and constructs a result set from database expressions and sources.

## 44. FROM
FROM defines the initial row source for a query.

## 45. WHERE
WHERE filters individual rows before grouping.

## 46. GROUP BY
GROUP BY forms groups of rows for aggregation.

## 47. HAVING
HAVING filters groups after grouping and aggregation logic.

## 48. ORDER BY
ORDER BY defines result ordering.

Without ORDER BY, relational results have no guaranteed presentation order.

## 49. LIMIT
LIMIT restricts how many rows are returned.

## 50. OFFSET
OFFSET skips rows before returning the remaining result.

## 51. DISTINCT
DISTINCT removes duplicate result rows based on the selected expressions.

## 52. Alias
An alias gives a temporary name to a table or expression.

## 53. Expression
An expression is SQL logic that evaluates to a value.

## 54. Predicate
A predicate is a condition that evaluates to a Boolean result in SQL's three-valued logic.

## 55. Operator
An operator performs or expresses an operation such as comparison, arithmetic or logical combination.

## 56. Literal
A literal is a value written directly in SQL, such as 42 or 'Ravi'.

## 57. Parameter
A parameter is a value supplied separately from SQL text, commonly used in prepared statements.

Parameterized queries reduce injection risk and allow statement reuse.

## 58. JOIN
JOIN combines row sources according to a relationship or condition.

## 59. INNER JOIN
INNER JOIN returns rows where the join condition matches.

## 60. LEFT JOIN
LEFT JOIN preserves all rows from the left source and matches right rows when available.

## 61. RIGHT JOIN
RIGHT JOIN preserves all rows from the right source.

## 62. FULL OUTER JOIN
FULL OUTER JOIN preserves unmatched rows from both sides and combines matching rows.

## 63. CROSS JOIN
CROSS JOIN produces the Cartesian product of two sources.

## 64. Self Join
A self join joins a table to itself, often for hierarchies such as employee-manager relationships.

## 65. Aggregate Function
An aggregate function calculates one result from multiple rows.

Examples: COUNT, SUM, AVG, MIN and MAX.

## 66. Scalar Function
A scalar function normally produces a value for each input row or expression.

## 67. GROUP
A group is the set of rows sharing the GROUP BY values.

## 68. Subquery
A subquery is a query nested inside another SQL statement.

## 69. Correlated Subquery
A correlated subquery references a value from an outer query row and may be evaluated in relation to that row.

## 70. EXISTS
EXISTS tests whether a subquery produces at least one row.

## 71. IN
IN tests whether a value matches one of a set of values or subquery results.

## 72. CTE
A Common Table Expression is a named query result defined with WITH for use by a statement.

## 73. Recursive CTE
A recursive CTE repeatedly evaluates a recursive term starting from an anchor result.

## 74. Window Function
A window function calculates across a related set of rows while retaining individual result rows.

## 75. PARTITION BY
PARTITION BY divides rows into independent windows for a window function.

## 76. Window Frame
A window frame defines the subset of rows considered for a window calculation around the current row.

## 77. ROW_NUMBER
ROW_NUMBER assigns sequential numbers within a window.

## 78. RANK
RANK gives tied rows the same rank and leaves gaps after ties.

## 79. DENSE_RANK
DENSE_RANK gives tied rows the same rank without gaps.

## 80. LAG / LEAD
LAG accesses a preceding row's value; LEAD accesses a following row's value.

## 81. CASE
CASE implements conditional expression logic.

## 82. COALESCE
COALESCE returns the first non-null expression.

## 83. NULLIF
NULLIF returns NULL when two expressions are equal; otherwise it returns the first expression.

## 84. UNION
UNION combines compatible result sets and removes duplicates.

## 85. UNION ALL
UNION ALL combines result sets without duplicate removal.

## 86. INTERSECT
INTERSECT returns rows common to both result sets.

## 87. EXCEPT
EXCEPT returns rows present in the first result and absent from the second.

## 88. Set Operation
A set operation combines compatible result sets according to mathematical set rules.

## 89. DDL
Data Definition Language changes database object definitions.

## 90. DML
Data Manipulation Language changes stored data.

## 91. DQL
Data Query Language is commonly used to describe data retrieval, especially SELECT.

## 92. DCL
Data Control Language manages permissions such as GRANT and REVOKE.

## 93. TCL
Transaction Control Language is commonly used to describe transaction commands such as COMMIT and ROLLBACK.

## 94. INSERT
INSERT adds rows.

## 95. UPDATE
UPDATE changes values in existing rows.

## 96. DELETE
DELETE removes rows.

## 97. UPSERT
UPSERT means handling an insert while defining behavior when a uniqueness conflict occurs.

## 98. MERGE
MERGE conditionally performs actions against a target based on source/target matching.

## 99. Normalization
Normalization organizes relational data to reduce unnecessary redundancy and modification anomalies.

## 100. Denormalization
Denormalization intentionally introduces redundancy or precomputed structures to support a workload.

## 101. Functional Dependency
A functional dependency means one attribute set determines another attribute set.

## 102. First Normal Form
1NF requires relational values to follow the model's atomic-value and row/column principles.

## 103. Second Normal Form
2NF removes partial dependency of non-key attributes on part of a composite candidate key.

## 104. Third Normal Form
3NF removes relevant transitive dependencies of non-key attributes on candidate keys.

## 105. Anomaly
A modification anomaly is an unintended data problem caused by poor data organization.

Common types are insert, update and delete anomalies.

## 106. Data Integrity
Data integrity means stored information remains accurate, valid and internally consistent according to defined rules.

## 107. Entity Integrity
Entity integrity requires each relation row to have an appropriate unique identity, typically through a primary key.

## 108. Domain Integrity
Domain integrity ensures values conform to the allowed type and business domain.

## 109. Transaction Isolation
Transaction isolation determines what effects of concurrent transactions are visible.

## 110. Dirty Read
A dirty read occurs when a transaction reads changes that another transaction has not committed.

## 111. Non-Repeatable Read
A non-repeatable read occurs when the same row read twice can produce different committed values during one transaction.

## 112. Phantom Read
A phantom occurs when repeated execution of a qualifying query observes a changed set of matching rows due to concurrent changes.

## 113. Lock
A lock coordinates concurrent access to resources.

## 114. Blocking
Blocking occurs when one operation must wait for another operation's conflicting lock or resource.

## 115. Deadlock
A deadlock occurs when transactions wait for one another in a cycle.

## 116. MVCC
Multi-Version Concurrency Control allows concurrent transactions to work with row versions according to visibility rules instead of relying only on blocking locks.

## 117. Isolation Level
An isolation level specifies concurrency visibility guarantees and permitted anomalies.

## 118. Read Committed
A PostgreSQL isolation level where each statement normally sees data committed before that statement's snapshot.

## 119. Repeatable Read
A PostgreSQL isolation level that provides a transaction-consistent snapshot with stronger repeatability than Read Committed.

## 120. Serializable
The strongest standard PostgreSQL isolation level, designed to make successful concurrent execution equivalent to some serial ordering, potentially requiring retries.

## 121. Cardinality Estimate
The planner's estimate of how many rows an operation will produce.

## 122. Selectivity
Selectivity describes how strongly a condition reduces the candidate row set.

## 123. Query Planner
The optimizer component that selects an execution strategy for a SQL statement.

## 124. Execution Plan
The selected operations the database uses to execute a query.

## 125. Sequential Scan
A scan that reads table pages to inspect rows.

## 126. Index Scan
A plan that uses an index to locate matching rows and then obtains table data as needed.

## 127. Bitmap Scan
A strategy that builds a bitmap of matching locations and then accesses table pages efficiently.

## 128. Query Optimization
The process of finding an efficient execution strategy while preserving query semantics.

## 129. Statistics
Metadata describing data distribution that helps the optimizer estimate costs and cardinalities.

## 130. Cost
An optimizer estimate used to compare execution strategies. It is not necessarily elapsed time.

## 131. Partition
A physical subdivision of a logical table.

## 132. Partition Pruning
The planner/executor avoids scanning partitions that cannot contain qualifying rows.

## 133. Sharding
Sharding distributes data across separate database nodes or shards.

## 134. Replication
Replication copies database changes or data to another server/system for availability, scaling or recovery purposes.

## 135. Backup
A stored copy or representation of database data used for recovery.

## 136. Restore
The process of reconstructing usable database state from recovery material.

## 137. RPO
Recovery Point Objective defines the maximum acceptable amount of data loss measured in time or recovery point.

## 138. RTO
Recovery Time Objective defines the target time to restore service after a failure.

## 139. Authentication
Authentication verifies who a database user or service is.

## 140. Authorization
Authorization determines what an authenticated identity may do.

## 141. Role
A role is a database identity that can own objects and/or receive permissions.

## 142. Privilege
A privilege grants permission to perform an operation on a database object.

## 143. GRANT
GRANT assigns privileges or role membership.

## 144. REVOKE
REVOKE removes privileges or memberships.

## 145. Least Privilege
Least privilege means granting only the permissions required for a task.

## 146. Row-Level Security
RLS controls access to individual rows based on policies.

## 147. SQL Injection
SQL injection is an attack where untrusted input changes the meaning of dynamically constructed SQL.

Use parameterized queries instead of concatenating untrusted values into SQL.

## 148. Audit
An audit record captures important information about an operation or change for accountability and investigation.

## 149. Idempotency
An operation is idempotent when repeating it produces the same intended final state.

## 150. OLTP
Online Transaction Processing focuses on operational, frequently changing workloads.

## 151. OLAP
Online Analytical Processing focuses on analytical queries over larger data sets.

## 152. Data Warehouse
A data warehouse is an analytical data platform optimized for reporting and historical analysis.

## 153. ETL
Extract, Transform, Load extracts data, transforms it, then loads the result.

## 154. ELT
Extract, Load, Transform loads source data first and performs transformations in the target analytical platform.

## 155. Data Pipeline
A data pipeline moves and transforms data through a sequence of processing stages.

## 156. Slowly Changing Dimension
An SCD technique manages changes to dimensional attributes over time, such as keeping historical customer addresses.

## 157. Connection Pool
A connection pool manages reusable database connections for applications.

## 158. Connection Pool Exhaustion
This occurs when an application requests more database connections than are available in its configured or database limits.

## 159. WAL
Write-Ahead Logging records change information in a log before the associated data changes are relied upon for crash recovery.

## 160. Checkpoint
A checkpoint writes required dirty data and metadata toward a consistent recovery point, reducing recovery work.

## 161. Vacuum
VACUUM reclaims or makes reusable space from obsolete row versions and performs related maintenance.

## 162. Autovacuum
PostgreSQL's automatic maintenance process that performs vacuum/analyze work according to configured thresholds.

## 163. Analyze
ANALYZE collects table statistics used by the optimizer.

## 164. Bloat
Bloat is excess physical space caused by obsolete row versions, index structure growth or other storage effects.

## 165. Schema Migration
A schema migration is a controlled change to database structure across environments.

## 166. Migration Version
A migration version identifies an ordered schema change so environments can be kept consistent.

## 167. Idempotent Migration
A migration is idempotent when safely reapplying it does not cause unintended repeated changes.

## 168. Connection
A connection is a communication session between a client/application and a database server.

## 169. Session
A session is the server-side context associated with a database connection.

## 170. Prepared Statement
A prepared statement separates SQL structure from supplied values and can allow statement planning/reuse.

## 171. Transaction Boundary
A transaction boundary defines where atomic database work begins and ends.

## 172. Business Rule
A business rule is a domain requirement that determines what data or operations are valid.

## 173. Data Model
A data model describes entities, attributes, relationships and rules.

## 174. Logical Data Model
A logical model describes business data structures independently of a specific physical storage implementation.

## 175. Physical Data Model
A physical model describes how the logical design is implemented in a particular database system.

## 176. ERD
An Entity-Relationship Diagram visually represents entities and relationships.

## 177. Referential Action
A foreign key can define what happens to dependent rows when referenced rows are updated or deleted, such as CASCADE or RESTRICT.

## 178. Cascade
CASCADE automatically propagates an allowed referenced-row operation to dependent rows.

## 179. Audit Trail
An audit trail is a chronological record of important changes or actions.

## 180. Production Readiness
Production readiness means the database solution has considered correctness, performance, security, availability, recovery, monitoring, operations and failure behavior.

## Core mental model

When solving any SQL problem, move through:

**Business question → Data model → Relationships → Required rows → Transformation → Result → Integrity → Performance → Concurrency → Security → Operations**

The query is only the implementation. The theory explains why that implementation is correct.
