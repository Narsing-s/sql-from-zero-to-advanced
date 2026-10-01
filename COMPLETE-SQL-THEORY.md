# Complete SQL Theory
## From Zero → Advanced → Expert → Production PostgreSQL

> **Purpose:** A modern, theory-first SQL reference. Learn the concept before the command, understand why it exists, then connect it to performance, concurrency, security, and production engineering.

---

## 🧭 Learning map

**FOUNDATION** → SQL, relational model, database objects, schemas, tables, rows, columns, data types  
**DESIGN** → entities, relationships, keys, constraints, normalization, ERD, modeling  
**QUERYING** → SELECT, filtering, expressions, NULL, joins, subqueries, set operations  
**ANALYTICS** → aggregation, GROUP BY, HAVING, windows, CTEs, recursive SQL  
**DATABASE PROGRAMMING** → views, functions, procedures, triggers, generated values  
**TRANSACTIONS** → ACID, isolation, MVCC, locks, deadlocks, concurrency  
**PERFORMANCE** → indexes, planner, EXPLAIN, statistics, vacuum, pooling, pagination  
**SECURITY** → roles, privileges, RLS, injection, encryption, auditing, secrets  
**POSTGRESQL EXPERT** → JSONB, arrays, ranges, full-text search, partitioning, extensions  
**DATA ENGINEERING** → ETL/ELT, CDC, warehouses, retention, incremental loads, lineage  
**DISTRIBUTED SYSTEMS** → replication, consistency, outbox, idempotency, recovery  
**PRODUCTION** → observability, incident response, migrations, backups, DR, safe change

### The lesson pattern

Every concept should be learned as:

**What is it? → Why does it exist? → Mental model → Syntax → Example → Result → Edge cases → Performance → Security → Concurrency → Production use → Practice → Interview**

---

# 1. SQL foundations

### What is SQL?
SQL (Structured Query Language) is a declarative language used to define database structures, retrieve data, modify data, control access, and manage transactions.

### Declarative vs procedural
- **Declarative:** describe the result you want.
- **Procedural:** describe the step-by-step algorithm.

The PostgreSQL optimizer chooses physical execution steps for a declarative SQL statement.

### Relational model
The relational model represents data using relations, attributes, tuples, and relationships.

In practical SQL:
- relation ≈ table
- tuple ≈ row
- attribute ≈ column

SQL extends pure relational theory with practical behavior such as duplicate rows, NULL, ordering, and implementation-specific features.

### Set vs bag semantics
Mathematical sets contain no duplicates. SQL commonly uses **bag/multiset semantics**, so duplicate rows can exist in intermediate and final results.

**Key consequence:** a one-to-many join can multiply rows.

### SQL command families

| Family | Purpose | Examples |
|---|---|---|
| DDL | Define structure | CREATE, ALTER, DROP, TRUNCATE |
| DML | Change data | INSERT, UPDATE, DELETE, MERGE |
| DQL | Read data | SELECT |
| DCL | Permissions | GRANT, REVOKE |
| TCL | Transactions | COMMIT, ROLLBACK, SAVEPOINT |

---

# 2. Database architecture and objects

### DBMS
Database Management System: software that manages storage, queries, transactions, security, concurrency, and recovery.

### RDBMS
A relational DBMS organized around tables, relationships, constraints, and relational operations.

### PostgreSQL architecture — simplified

**Client → Connection → Parser → Analyzer → Rewriter → Planner/Optimizer → Executor → Storage**

Important background components include:
- shared buffers
- WAL
- background writer
- checkpointer
- autovacuum
- statistics collector/catalogs

### Database vs schema vs table

**Server → Database → Schema → Table → Row → Column → Value**

- **Database:** logical database within the PostgreSQL server.
- **Schema:** namespace for objects.
- **Table:** persistent relation containing rows.
- **Session:** one client connection with its own settings and transaction state.

### Important PostgreSQL objects
- tables
- indexes
- sequences
- identity columns
- views
- materialized views
- functions
- procedures
- triggers
- types
- domains
- enums
- extensions
- temporary tables
- unlogged tables
- foreign tables

### Catalog
PostgreSQL stores metadata about databases, tables, columns, indexes, roles, functions and other objects in system catalogs such as `pg_class`, `pg_attribute`, `pg_index`, and `pg_proc`.

---

# 3. Data modeling

### Entity
A business object such as Customer, Account, Order, Product, or Employee.

### Attribute
A property of an entity.

### Relationship
An association between entities.

### Cardinality
Defines relationship quantity:
- 1:1
- 1:N
- N:M

### Optionality
Whether participation is required or optional.

### Grain
The exact meaning of one row.

> **Rule:** Before writing an analytical query, state the grain.

Example:

**One row = one transaction**

is fundamentally different from:

**One row = one account**

### ERD
An Entity Relationship Diagram visualizes entities, attributes, keys, and relationships.

### Logical vs physical model

**Business model → Logical model → Physical PostgreSQL model**

Physical design adds:
- data types
- indexes
- partitions
- storage choices
- PostgreSQL-specific constraints

---

# 4. Data types

A data type defines what values can be stored and how PostgreSQL interprets them.

### Numeric
- smallint
- integer
- bigint
- numeric/decimal
- real
- double precision

### Text
- text
- varchar(n)
- char(n)

### Boolean
`TRUE`, `FALSE`, and NULL.

### Date/time
- date
- time
- timestamp
- timestamptz
- interval

**Important:** `timestamptz` represents an instant; it does not store a named time zone.

### Identifiers
- bigint identity
- UUID

### Semi-structured
- json
- jsonb

### Collections
- arrays
- ranges
- multiranges

### Specialized
- enum
- domain
- composite type

### CAST
Explicit conversion makes intent clear:

`CAST(value AS type)` or `value::type`

### Collation
Collation determines text comparison and sorting rules.

### Money
For financial calculations, deliberate use of `numeric` with appropriate precision/scale is generally preferable to floating-point arithmetic.

---

# 5. Keys and constraints

### Candidate key
Minimal attribute set that uniquely identifies a row.

### Primary key
Chosen candidate key used as the table's main identity.

### Natural key
Business-derived identifier.

### Surrogate key
Generated identifier without business meaning.

### Foreign key
Maintains a valid relationship to another table.

### Constraint types
- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- CHECK
- EXCLUDE

### Foreign-key actions
Understand:
- NO ACTION
- RESTRICT
- CASCADE
- SET NULL
- SET DEFAULT

### Deferrable constraints
A constraint can be checked at transaction commit rather than immediately when configured as DEFERRABLE.

### Partial unique index
Can enforce a business rule for only a subset of rows.

Example concept:

**one active subscription per customer**

### Business invariant
A rule that must remain true even under concurrent writes.

---

# 6. Normalization and relational theory

### Functional dependency
If A determines B, B functionally depends on A.

### Normal forms

**1NF → 2NF → 3NF → BCNF**

- **1NF:** atomic/relation-compatible values and no uncontrolled repeating groups.
- **2NF:** no partial dependency on part of a composite candidate key.
- **3NF:** no inappropriate transitive dependency through non-key attributes.
- **BCNF:** every determinant of a non-trivial functional dependency is a candidate key.

### Higher normalization
For expert study:
- 4NF — multivalued dependencies
- 5NF — join dependencies
- Domain-Key Normal Form — constraints expressed through domains and keys

### Denormalization
Intentional redundancy for a measured workload.

### Anomalies
Poor design can cause:
- insertion anomaly
- update anomaly
- deletion anomaly

---

# 7. SQL expressions and predicates

### Expression
Produces a value.

### Predicate
Produces a condition used for filtering.

### Operators

**Comparison:** `=`, `<>`, `<`, `>`, `<=`, `>=`

**Logical:** `AND`, `OR`, `NOT`

**Membership:** `IN`, `NOT IN`

**Existence:** `EXISTS`, `NOT EXISTS`

**Set comparison:** `ANY/SOME`, `ALL`

**Pattern:** `LIKE`, `ILIKE`

**Range:** `BETWEEN`

PostgreSQL additionally supports regular-expression, array, JSONB, range, geometric, and full-text operators.

### Operator precedence
Complex predicates should be parenthesized when readability or correctness could be ambiguous.

---

# 8. SELECT and logical query processing

### Basic model

```
FROM / JOIN
    ↓
WHERE
    ↓
GROUP BY
    ↓
HAVING
    ↓
SELECT
    ↓
DISTINCT
    ↓
ORDER BY
    ↓
LIMIT / OFFSET
```

This is a **logical model**, not a promise about physical execution order.

### Core clauses
- SELECT — choose expressions
- FROM — establish source rows
- WHERE — filter rows
- GROUP BY — create groups
- HAVING — filter groups
- ORDER BY — define result order
- DISTINCT — remove duplicate result rows
- LIMIT/OFFSET — restrict returned rows

### Deterministic ordering
Without an appropriate ORDER BY, row order is not guaranteed.

---

# 9. NULL and three-valued logic

NULL means missing, unknown, or not applicable depending on the model.

SQL predicates can evaluate to:

**TRUE / FALSE / UNKNOWN**

WHERE keeps only TRUE.

### Rules
- `NULL = NULL` → UNKNOWN
- use `IS NULL`
- use `IS NOT NULL`
- `IS DISTINCT FROM` provides NULL-safe comparison
- `COALESCE` chooses the first non-NULL value
- `NULLIF` converts a matching value into NULL

### Critical edge case

`NOT IN` can behave unexpectedly when the subquery contains NULL.

For many existence checks, `NOT EXISTS` is safer and clearer.

### Aggregates and NULL
- `COUNT(*)` counts rows
- `COUNT(column)` ignores NULL
- SUM/AVG/MIN/MAX generally ignore NULL inputs

---

# 10. Filtering and conditional logic

### WHERE
Filters rows before aggregation.

### HAVING
Filters groups after aggregation.

### CASE
Conditional expression:

```sql
CASE
  WHEN condition THEN result
  ELSE fallback
END
```

### COALESCE
Returns the first non-NULL expression.

### NULLIF
Returns NULL when two expressions are equal; useful for avoiding divide-by-zero patterns.

---

# 11. Joins

### Join types

| Join | Meaning |
|---|---|
| INNER | Matching rows |
| LEFT | All left rows + matches |
| RIGHT | All right rows + matches |
| FULL | Rows from both sides |
| CROSS | Cartesian product |
| SELF | Table joined to itself |
| LATERAL | Right-side expression can reference preceding FROM rows |

### Join condition
`ON` defines how rows relate.

### ON vs WHERE
Moving a condition between ON and WHERE can change LEFT/RIGHT/FULL JOIN semantics.

### Join multiplication

**1 customer → many accounts → many result rows**

Always verify result grain after joins.

### Many-to-many
Usually implemented using a junction/association table.

---

# 12. Subqueries and set operations

### Subquery
Query nested inside another query.

### Correlated subquery
References an outer query row.

### EXISTS
Checks whether at least one matching row exists.

### IN
Checks membership in a result set.

### ANY / ALL
Compare a value against one or every value from a set.

### Set operations

- UNION — combine and remove duplicates
- UNION ALL — combine and preserve duplicates
- INTERSECT — common rows
- EXCEPT — first result minus second result

Inputs must have compatible column counts/types.

---

# 13. Aggregation

### Aggregate
Combines multiple rows into a summary.

Common aggregates:
- COUNT
- SUM
- AVG
- MIN
- MAX
- STRING_AGG
- ARRAY_AGG
- JSON_AGG / JSONB_AGG

### GROUP BY
Creates one result group per grouping key.

### FILTER
Applies a condition to one aggregate.

### Advanced grouping
- GROUPING SETS
- ROLLUP
- CUBE

### Common failure
Joining multiple one-to-many tables before aggregation can multiply values and produce incorrect totals.

---

# 14. Window functions

Window functions calculate across related rows **without collapsing them**.

### Structure

```sql
function(...) OVER (
  PARTITION BY ...
  ORDER BY ...
  frame
)
```

### Core functions
- ROW_NUMBER
- RANK
- DENSE_RANK
- LAG
- LEAD
- FIRST_VALUE
- LAST_VALUE
- NTH_VALUE
- SUM
- AVG
- MIN
- MAX

### Window frame
- ROWS
- RANGE
- GROUPS

Frame behavior is especially important for running totals and peer/tie handling.

### GROUP BY vs window

**GROUP BY → fewer rows**

**Window → same rows + analytical value**

---

# 15. CTEs and recursive SQL

### CTE
A named intermediate query using `WITH`.

Benefits:
- decomposition
- readability
- reuse inside one statement

A CTE is not automatically faster.

### Recursive CTE

**Anchor → recursive member → next level → termination**

Useful for:
- employee hierarchies
- categories
- folders
- dependency graphs
- bill of materials
- graph traversal

Always design termination and cycle handling.

---

# 16. Data modification

### INSERT
Creates rows.

### UPDATE
Changes existing rows.

### DELETE
Removes rows.

### TRUNCATE
Removes all rows efficiently with different locking/transaction behavior from DELETE.

### RETURNING
PostgreSQL can return affected rows directly.

### UPSERT

`INSERT ... ON CONFLICT ... DO UPDATE/NOTHING`

Useful for idempotent writes when the conflict key represents the business identity.

### MERGE
Matches source and target rows and conditionally performs INSERT, UPDATE, or DELETE.

### Safe mutation workflow

**Identify → Preview → Transaction → Modify → Verify → Commit/Rollback**

---

# 17. Database objects and DDL

### CREATE
Creates an object.

### ALTER
Changes an existing object.

### DROP
Removes an object.

### Identity columns
Prefer identity columns for modern generated numeric identifiers where appropriate.

### Sequences
Independent number generators used directly or by serial/identity-style designs.

### Temporary tables
Session/transaction-scoped working tables.

### Unlogged tables
Reduce WAL overhead but lose durability characteristics after crash/restart; unsuitable for critical primary data.

### Generated columns
Database-computed stored values derived from other columns.

---

# 18. Views and materialized views

### View
Stored query definition exposed like a table.

Use for:
- abstraction
- reusable logic
- reporting interfaces
- controlled exposure

### Materialized view
Physically stores query results.

Use when:
- computation is expensive
- data can be slightly stale
- refresh is operationally acceptable

Understand:
- REFRESH MATERIALIZED VIEW
- CONCURRENTLY requirements
- refresh cost
- staleness

---

# 19. Functions, procedures and triggers

### Function
Reusable database logic that returns a value or set.

### Procedure
Callable database operation invoked with CALL and designed for procedural/database-side work.

### PL/pgSQL
PostgreSQL's procedural language.

Know:
- variables
- IF
- CASE
- loops
- exceptions
- dynamic SQL
- RECORD
- RETURN/RETURN QUERY

### Trigger
Automatically invokes trigger logic on configured events.

Know:
- BEFORE
- AFTER
- INSTEAD OF
- row-level
- statement-level
- OLD
- NEW

### Trigger risks
Hidden side effects, latency, recursive behavior, debugging difficulty, and unexpected write amplification.

---

# 20. Transactions and ACID

### Transaction
Logical unit of work.

### ACID

| Property | Meaning |
|---|---|
| Atomicity | All or nothing |
| Consistency | Integrity rules remain valid |
| Isolation | Concurrent work follows isolation rules |
| Durability | Committed changes survive the defined failure model |

### Commands
- BEGIN
- COMMIT
- ROLLBACK
- SAVEPOINT
- RELEASE SAVEPOINT
- ROLLBACK TO SAVEPOINT

### Transaction boundaries
Keep transactions short enough to reduce lock duration and resource retention, while keeping all logically atomic work together.

---

# 21. Isolation levels and anomalies

### Anomalies
- dirty read
- non-repeatable read
- phantom read
- lost update
- write skew
- serialization anomaly

### PostgreSQL isolation
Understand:
- READ COMMITTED
- REPEATABLE READ
- SERIALIZABLE

PostgreSQL's implementation details matter; do not assume textbook behavior maps perfectly to PostgreSQL.

### Serializable
Provides strong serializable semantics but transactions can fail with serialization errors and applications may need safe retries.

---

# 22. MVCC

**MVCC = Multi-Version Concurrency Control**

PostgreSQL uses row versions and snapshots so readers and writers can often proceed concurrently.

Key concepts:
- tuple versions
- snapshots
- transaction IDs
- visibility
- dead tuples
- vacuum
- freezing

### Why MVCC matters
It explains:
- why UPDATE creates row versions
- why old tuples exist
- why vacuum matters
- why long transactions can be harmful

---

# 23. Locks, blocking and deadlocks

### Locks
Coordinate conflicting operations.

Important concepts:
- row locks
- table locks
- lock modes
- blocking
- lock wait
- lock timeout

### Deadlock

**Transaction A waits for B → B waits for A → cycle**

Prevention:
- consistent lock ordering
- short transactions
- avoid unnecessary locks
- safe retry logic

### Advisory locks
Application-defined coordination mechanism.

### Optimistic vs pessimistic concurrency
- **Optimistic:** detect conflict when writing.
- **Pessimistic:** lock before modifying.

### Atomic update
Prefer database-enforced conditional mutations over unsafe application-level SELECT-then-UPDATE patterns.

---

# 24. Query planner and optimizer

### Physical execution model

**SQL → parse → analyze → rewrite → estimate → plan → execute**

### Cost-based optimization
The planner compares possible strategies using:
- estimated rows
- selectivity
- statistics
- I/O cost
- CPU cost
- memory considerations

### Cardinality
Expected number of rows.

### Selectivity
Expected fraction of rows matching a predicate.

### Statistics
Help the planner estimate data distribution.

### Extended statistics
Capture relationships between columns that independent statistics cannot represent well.

---

# 25. EXPLAIN and execution plans

### EXPLAIN
Shows the planned execution strategy.

### EXPLAIN ANALYZE
Actually executes the query and reports observed timing/rows.

### EXPLAIN BUFFERS
Shows buffer activity and helps distinguish memory/cache behavior from physical reads.

### Important plan nodes
- Seq Scan
- Index Scan
- Index Only Scan
- Bitmap Heap Scan
- Bitmap Index Scan
- Nested Loop
- Hash Join
- Merge Join
- Sort
- Aggregate
- HashAggregate
- GroupAggregate
- Gather
- Gather Merge

### Diagnosis

**Estimated rows vs actual rows**

Large differences can indicate:
- stale statistics
- skew
- correlated columns
- parameter distribution
- planner limitations

---

# 26. Index theory

### Why indexes exist
An index provides an alternate access path to table data.

### Trade-off

**Faster reads ↔ storage + write/update/delete maintenance**

### Index types

| Type | Common use |
|---|---|
| B-tree | ordered/equality/range |
| Hash | equality |
| GIN | JSONB, arrays, text-search structures |
| GiST | ranges, geometric/specialized operators |
| SP-GiST | suitable partitioned search structures |
| BRIN | huge naturally ordered tables |

### Advanced indexes
- multicolumn
- partial
- expression
- covering/INCLUDE
- unique
- concurrent creation

### Multicolumn indexes
Column order matters.

### Partial index
Indexes only rows satisfying a predicate.

### Expression index
Indexes a calculated expression.

### Covering index
INCLUDE columns can support index-only access without becoming index key columns.

### Sargability
Write predicates in forms that allow efficient use of available access paths.

---

# 27. Pagination and query patterns

### OFFSET pagination
Simple but increasingly expensive for deep pages.

### Keyset pagination

**Last seen key → seek to next range**

Usually scales better for large ordered datasets.

### Top-N per group
Common techniques:
- ROW_NUMBER
- RANK
- DISTINCT ON
- LATERAL

### N+1 query problem

**Fetch list → one query per item**

Prefer:
- joins
- batching
- IN queries
- carefully designed data loaders

---

# 28. PostgreSQL storage internals

### Heap
Main table storage.

### Page
Basic storage unit.

### Tuple
A row version.

### Dead tuple
Old row version no longer needed by active snapshots.

### WAL
Write-Ahead Log records changes for durability and recovery.

### Checkpoint
Writes dirty pages and establishes a recovery boundary.

### Visibility map
Tracks page visibility properties used by vacuum and index-only scans.

### Free-space map
Tracks available page space.

### TOAST
Handles oversized field values.

### Transaction ID wraparound
Transaction IDs are finite; freezing and vacuum maintenance are required to prevent wraparound failure.

---

# 29. VACUUM, ANALYZE and bloat

### VACUUM
Makes dead tuple space reusable and maintains visibility information.

### ANALYZE
Collects planner statistics.

### Autovacuum
Automatically performs maintenance.

### Bloat
Inefficient storage caused by row-version churn and other storage behavior.

### Long-running transactions
Can prevent old row versions from becoming removable.

### Production checks
Monitor:
- dead tuples
- autovacuum activity
- table/index growth
- long transactions
- transaction age
- statistics freshness

---

# 30. Connection pooling

A pool reuses connections and limits concurrent database connections.

### Pool exhaustion causes
- connection leaks
- slow queries
- long transactions
- oversized concurrency
- undersized pool
- overloaded database

### Important principle
Increasing the pool does not automatically increase throughput. It can overload the database.

---

# 31. Prepared statements and parameterization

### Prepared statement
Separates SQL structure from parameter values.

Benefits:
- protects against SQL injection when used correctly
- reduces repeated parsing
- can reuse execution plans

### Generic vs custom plans
PostgreSQL may choose different planning strategies based on parameters and workload.

### Parameter sensitivity
A plan good for one value distribution may be poor for another.

---

# 32. Security

### Authentication
**Who are you?**

### Authorization
**What are you allowed to do?**

### Roles
PostgreSQL roles can represent users, groups, or service identities.

### Privileges
- CONNECT
- USAGE
- SELECT
- INSERT
- UPDATE
- DELETE
- EXECUTE
- ownership and object-specific privileges

### GRANT / REVOKE
Control access.

### Default privileges
Control privileges for future objects.

### Least privilege
Give only required access.

### SQL injection
Untrusted input changes SQL structure.

**Defense: parameterized queries.**

Never rely on escaping alone as the primary defense.

---

# 33. Row-Level Security

RLS applies policies at row level.

### Mental model

**Session identity/context → policy → permitted rows**

Know:
- ENABLE/DISABLE ROW LEVEL SECURITY
- USING
- WITH CHECK
- role behavior
- table owners
- BYPASSRLS
- FORCE ROW LEVEL SECURITY

RLS is an enforcement layer, not a complete application authorization model.

---

# 34. SECURITY DEFINER / INVOKER

### SECURITY INVOKER
Runs with caller privileges.

### SECURITY DEFINER
Runs with function-owner privileges.

Security-definer functions require careful:
- ownership
- search_path
- object qualification
- input validation
- privilege design

---

# 35. Auditing, privacy and sensitive data

### Audit trail
Useful fields:
- actor
- timestamp
- action
- object
- object ID
- old state
- new state
- request/correlation ID

### Data masking
Reduce exposure of sensitive values.

### Retention
Define how long data should remain available.

### Deletion
Consider:
- primary database
- replicas
- archives
- backups
- derived datasets

### Secrets
Never hardcode:
- passwords
- API keys
- private certificates
- connection credentials

---

# 36. JSON and JSONB

### JSON
Stores JSON text representation.

### JSONB
Stores decomposed binary representation optimized for processing/indexing.

### Operators
Know:
- `->`
- `->>`
- `#>`
- `#>>`
- `@>`
- `?`
- `?&`
- `?|`
- concatenation/update operators

### Design rule

**Stable, frequently queried relational facts → columns**

**Flexible/semi-structured attributes → JSONB when justified**

### JSONB indexing
GIN is commonly used for suitable containment/existence workloads.

---

# 37. Arrays

PostgreSQL supports arrays as first-class values.

Know:
- indexing
- slicing
- array operators
- ANY
- ALL
- unnest
- array aggregation

### Design caution
Arrays are useful for genuinely grouped values, but relationships requiring independent identity, constraints, or joins are often better modeled as child rows.

---

# 38. Range and multirange types

Range represents an interval such as:
- date range
- timestamp range
- numeric range

Understand:
- inclusive/exclusive bounds
- empty ranges
- containment
- overlap
- range operators

Multirange represents multiple non-contiguous ranges.

### Production use
Scheduling, validity periods, reservations, pricing windows, temporal rules.

---

# 39. Exclusion constraints

Exclusion constraints prevent conflicting rows according to operator relationships.

Classic example:

**Do not allow overlapping room reservations.**

They are especially powerful with range types and GiST indexes.

---

# 40. Full-text search

### Basic model

**Text → tsvector**

**Search phrase → tsquery**

**Match → @@**

Learn:
- stemming
- dictionaries
- configurations
- ranking
- highlighting
- GIN indexes

Full-text search is different from simple substring matching with LIKE.

---

# 41. Dates, time zones and temporal logic

### Important distinctions
- date = calendar date
- timestamp = date/time without time-zone semantics
- timestamptz = absolute instant displayed in session time zone
- interval = duration/calendar interval

### Common production problems
- storing local time instead of an instant
- daylight-saving changes
- ambiguous local times
- comparing timestamps across zones
- incorrect interval assumptions

### Temporal models
- valid time
- transaction/system time
- effective-from/effective-to
- historical corrections

---

# 42. Partitioning

Partitioning divides one logical table into physical partitions.

### Strategies
- RANGE
- LIST
- HASH

### Benefits
- partition pruning
- lifecycle management
- smaller local structures
- easier retention for some workloads

### Costs
- operational complexity
- partition management
- planning overhead
- poor partition-key choices

Partitioning does not replace indexes.

---

# 43. Data warehousing and analytics

### OLTP
Optimized for transactional operations.

### OLAP
Optimized for analytical queries.

### Fact
Business event/measurable observation.

### Dimension
Descriptive context.

### Star schema

**Dimensions → Fact**

### Snowflake schema
Dimensions are further normalized.

### Grain
Defines exactly what each fact row represents.

### Slowly Changing Dimensions
Common patterns:
- Type 0 — never change
- Type 1 — overwrite
- Type 2 — preserve history with versions
- Type 3 — limited previous-value history

---

# 44. ETL and ELT

### ETL

**Extract → Transform → Load**

### ELT

**Extract → Load → Transform**

### Pipeline concepts
- source
- staging
- validation
- transformation
- deduplication
- load
- watermark
- checkpoint
- late-arriving data
- retry
- replay
- lineage
- quality checks

### Idempotency
Running the same operation again produces the same intended business outcome.

---

# 45. Change Data Capture

CDC captures inserts, updates, and deletes for downstream consumers.

PostgreSQL supports logical decoding and logical replication mechanisms useful for CDC architectures.

### CDC challenges
- ordering
- duplicates
- retries
- offsets
- replay
- schema changes
- deletes
- tombstones
- consumer lag

---

# 46. Replication

### Physical replication
Replicates WAL/storage-level changes.

### Logical replication
Replicates logical row changes through publications/subscriptions.

### Read replica
Replica used for read workloads.

### Replication lag
Difference between source progress and replica replay.

### Read-after-write
A write followed immediately by a replica read can observe stale data.

### Replication slots
Retain WAL until consumers advance; abandoned slots can cause WAL growth.

---

# 47. Backup and disaster recovery

### Logical backup
Logical representation of schema/data.

### Physical backup
Physical database storage for recovery.

### WAL archiving
Preserves recovery history.

### PITR
Point-in-time recovery using backups plus WAL.

### RPO
Maximum acceptable data loss measured in time.

### RTO
Maximum acceptable recovery time.

### HA
High availability reduces service interruption during failures.

### Golden rule

**A backup is not proven until restoration has been tested.**

Run recovery drills.

---

# 48. Distributed database patterns

### Strong consistency
Operations follow a defined strong consistency model.

### Eventual consistency
Replicas can temporarily differ before converging.

### Two-phase commit
Coordinates distributed participants through prepare and commit; powerful but operationally expensive.

### Saga
Breaks distributed work into local transactions with compensating actions.

### Outbox pattern

**Business change + event record → same local transaction → publisher**

### Inbox pattern
Record consumed event IDs to safely handle duplicate delivery.

### Idempotent consumer
Repeated delivery produces the same intended business effect.

---

# 49. Schema evolution and migrations

### Migration
Controlled database structure/data change.

### Expand-and-contract

**Add compatible structure → deploy compatible code → backfill → switch → remove old structure**

### Zero-downtime concerns
Check:
- locks
- table size
- index creation
- replication
- application compatibility
- rollback
- deployment order

### Large backfills
Use:
- batching
- throttling
- progress tracking
- retries
- observability
- safe checkpoints

---

# 50. Production observability

Monitor:

### Database health
- CPU
- memory
- I/O
- disk
- WAL
- connections
- cache behavior

### Query health
- latency
- throughput
- errors
- query frequency
- plan changes
- temporary spills

### Concurrency
- lock waits
- deadlocks
- long transactions
- idle-in-transaction sessions

### Maintenance
- autovacuum
- dead tuples
- table/index growth
- statistics

### Replication
- replay lag
- slot lag
- WAL retention

---

# 51. Production troubleshooting

## Slow query

**Exact SQL + parameters → latency → EXPLAIN ANALYZE → BUFFERS → estimates → scans/joins → indexes → locks → CPU/I/O → statistics → one change → remeasure**

## Duplicate data

**Define business key → find duplicates → select canonical record → clean safely → add prevention constraint**

## Deadlock

**Identify sessions → inspect lock graph → establish consistent ordering → shorten transactions → retry safely**

## Connection exhaustion

**Inspect pool → leaks → long transactions → slow queries → database capacity → only then adjust pool**

## Outage

**Scope → connectivity → server health → connections → storage → locks → replication → recent changes → protect data → restore → validate → RCA**

---

# 52. Planner regression

A previously good query plan can change because of:
- data growth
- distribution changes
- statistics
- schema changes
- indexes
- PostgreSQL upgrades
- parameter distribution

For critical workloads:

**Baseline → change → compare plan → benchmark → monitor**

---

# 53. Advanced PostgreSQL features

Expert learners should understand:

- generated columns
- domains
- enums
- composite types
- arrays
- ranges/multiranges
- exclusion constraints
- deferrable constraints
- partial/expression indexes
- INCLUDE indexes
- partition-wise joins
- partition-wise aggregation
- foreign data wrappers
- logical decoding
- publications/subscriptions
- replication slots
- advisory locks
- custom statistics
- planner configuration
- extensions
- PostGIS/geospatial concepts

---

# 54. SQL correctness checklist

Before approving SQL, ask:

### Data correctness
- What is the row grain?
- Can joins multiply rows?
- How does NULL behave?
- Are duplicates expected?
- Are constraints protecting the invariant?
- Are time zones handled correctly?

### Query correctness
- Are filters applied at the right stage?
- Is GROUP BY correct?
- Is HAVING being used for group filtering?
- Are window frames correct?
- Is ordering deterministic?

### Mutation correctness
- Which rows change?
- Is the operation atomic?
- Is it idempotent?
- What happens on retry?
- What happens if only part of the work succeeds?

---

# 55. SQL performance checklist

Ask:

1. How many rows exist now?
2. How many rows will exist later?
3. What does EXPLAIN show?
4. Are estimated and actual rows close?
5. Is the access path appropriate?
6. Are joins multiplying data?
7. Is sorting/hashing spilling?
8. Is the predicate sargable?
9. Is the index appropriate?
10. Is the query part of an N+1 pattern?
11. Is pagination scalable?
12. Is connection concurrency reasonable?

**Measure first. Optimize second.**

---

# 56. SQL security checklist

Ask:

- Are parameters bound?
- Is least privilege enforced?
- Who owns the object?
- Who can execute the function?
- Is RLS required?
- Can tenant boundaries be bypassed?
- Are SECURITY DEFINER functions hardened?
- Is `search_path` safe?
- Is sensitive data exposed?
- Is traffic encrypted?
- Are secrets outside source control?
- Are security events auditable?

---

# 57. Production design patterns

### Idempotent write
Same request/event can safely be retried.

### Optimistic locking
Use a version/timestamp to detect concurrent modification.

### Pessimistic locking
Lock the resource before changing it.

### Outbox
Persist event and business change atomically.

### Inbox
Track consumed events.

### Soft delete
Use a deletion marker when recovery/history is required.

### Multi-tenancy
Common models:
- shared database/shared schema
- shared database/separate schema
- separate database

### Tenant isolation
Use explicit tenant keys and, where appropriate, RLS.

---

# 58. Temporal, hierarchical and multi-tenant modeling

### Temporal
Represent facts across time with:
- effective dates
- validity ranges
- history tables
- range constraints

### Hierarchical
Models:
- adjacency list
- materialized path
- closure table

Recursive CTEs are especially useful for adjacency-list trees.

### Multi-tenant
Always define:
- tenant identity
- isolation boundary
- authorization
- indexing strategy
- migration strategy
- backup/recovery boundary

---

# 59. Advanced relational concepts

For expert learners:

### Relational algebra
Understand:
- selection
- projection
- join
- union
- difference
- Cartesian product

### Functional dependencies
Used to reason about normalization and candidate keys.

### Relational division
Useful conceptually for queries such as:

> customers who satisfy **all** required conditions.

### Three-valued logic
Critical for NULL-aware relational reasoning.

### Declarative optimization
The optimizer transforms a declarative request into an efficient physical plan while preserving required semantics.

---

# 60. SQL testing

Production-quality SQL should be tested at multiple levels.

### Unit-style tests
Verify a query/function against controlled fixtures.

### Data-quality tests
Validate:
- uniqueness
- not-null rules
- referential integrity
- accepted values
- ranges
- freshness

### Integration tests
Verify SQL against a real PostgreSQL instance.

### Concurrency tests
Run competing transactions to expose:
- lost updates
- deadlocks
- serialization failures
- race conditions

### Migration tests
Test:
- forward migration
- rollback strategy
- large-data behavior
- lock impact
- compatibility

---

# 61. SQL deployment lifecycle

**Design → Migration → Test → Review → Deploy → Observe → Validate → Roll back/forward safely**

For high-risk changes:
- use staged deployment
- monitor locks
- monitor latency
- monitor replication
- prepare rollback/forward strategy
- validate data after deployment

---

# 62. Expert mental model

A production SQL engineer thinks in layers:

**Business requirement**  
↓  
**Business invariant**  
↓  
**Row grain**  
↓  
**Entities + relationships**  
↓  
**Keys + constraints**  
↓  
**Normalization / deliberate denormalization**  
↓  
**Transaction boundary**  
↓  
**SQL semantics**  
↓  
**NULL / duplicates / joins**  
↓  
**Execution plan**  
↓  
**Indexes / statistics / storage**  
↓  
**Concurrency / locks / MVCC**  
↓  
**Security / authorization**  
↓  
**Observability**  
↓  
**Backup / recovery**  
↓  
**Safe schema evolution**

---

# 63. Definition of SQL mastery

You have mastered a SQL concept when you can explain:

- **What** it is
- **Why** it exists
- **When** to use it
- **When not** to use it
- **How** the syntax works
- **What** result it produces
- **How NULL affects it**
- **How duplicates affect it**
- **What happens internally**
- **How the planner may execute it**
- **How to measure performance**
- **How concurrency affects it**
- **How to secure it**
- **How to troubleshoot it**
- **How to test it**
- **How to deploy it safely**

---

# 64. Recommended learning sequence

### 🟢 Beginner
1. SQL concepts
2. Database/schema/table
3. Data types
4. CREATE TABLE
5. INSERT
6. SELECT
7. WHERE
8. ORDER BY
9. LIMIT
10. NULL
11. UPDATE
12. DELETE

### 🔵 Intermediate
13. Constraints
14. Relationships
15. JOINs
16. GROUP BY
17. HAVING
18. CASE
19. Subqueries
20. EXISTS
21. UNION/INTERSECT/EXCEPT
22. CTEs

### 🟣 Advanced
23. Window functions
24. Recursive CTEs
25. Views
26. Functions
27. Procedures
28. Triggers
29. Transactions
30. Isolation
31. MVCC
32. Locks

### 🔴 Expert
33. EXPLAIN
34. Planner/cardinality
35. Index design
36. Vacuum/storage
37. JSONB
38. Arrays/ranges
39. Full-text search
40. Partitioning
41. RLS
42. Advanced constraints
43. Replication
44. CDC
45. Backup/PITR
46. Distributed patterns
47. Production troubleshooting

---

## 🧠 Final rule

> **Do not learn SQL as a list of commands. Learn it as a system of data modeling, relational semantics, correctness, execution, concurrency, security, and production engineering.**

That is the difference between **knowing SQL syntax** and **engineering with SQL**.
