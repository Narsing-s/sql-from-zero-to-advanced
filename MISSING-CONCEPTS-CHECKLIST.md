# SQL Missing Concepts & Completeness Checklist

This checklist closes the gaps that are often missed in SQL courses. Use it as a curriculum map.

## Core language and semantics
- [ ] SQL standard vs PostgreSQL-specific behavior
- [ ] Relational model and relation properties
- [ ] Bag/multiset semantics and why SQL results can contain duplicates
- [ ] NULL and three-valued logic
- [ ] Type coercion and implicit casts
- [ ] Explicit CAST and type conversion
- [ ] Collation and text comparison
- [ ] Character sets/encodings
- [ ] Date, time, timestamp and timezone semantics
- [ ] INTERVAL and temporal arithmetic
- [ ] Numeric precision, scale, rounding and overflow
- [ ] Boolean semantics
- [ ] UUIDs
- [ ] Arrays
- [ ] Composite/record values
- [ ] Domains
- [ ] Enums
- [ ] Range and multirange types

## Query language
- [ ] SELECT and logical query processing
- [ ] FROM and table expressions
- [ ] WHERE
- [ ] GROUP BY
- [ ] HAVING
- [ ] ORDER BY
- [ ] LIMIT/OFFSET
- [ ] DISTINCT
- [ ] DISTINCT ON
- [ ] JOIN variants
- [ ] CROSS JOIN
- [ ] LATERAL
- [ ] Subqueries
- [ ] EXISTS / NOT EXISTS
- [ ] ANY / ALL
- [ ] IN / NOT IN and NULL behavior
- [ ] UNION / UNION ALL
- [ ] INTERSECT
- [ ] EXCEPT
- [ ] CASE
- [ ] COALESCE
- [ ] NULLIF
- [ ] FILTER
- [ ] Ordered aggregates
- [ ] GROUPING SETS
- [ ] ROLLUP
- [ ] CUBE
- [ ] Window functions
- [ ] Window frames
- [ ] Named windows
- [ ] Recursive CTEs
- [ ] SEARCH/CYCLE concepts for hierarchical queries

## Data modification
- [ ] INSERT
- [ ] UPDATE
- [ ] DELETE
- [ ] RETURNING
- [ ] INSERT ... SELECT
- [ ] UPSERT / ON CONFLICT
- [ ] MERGE
- [ ] Multi-row writes
- [ ] Safe bulk updates/deletes
- [ ] Write amplification
- [ ] Trigger side effects

## Data definition
- [ ] CREATE/ALTER/DROP
- [ ] Tables
- [ ] Schemas
- [ ] Sequences
- [ ] Identity columns
- [ ] Temporary tables
- [ ] Unlogged tables
- [ ] Views
- [ ] Materialized views
- [ ] Functions
- [ ] Procedures
- [ ] Triggers
- [ ] Generated columns
- [ ] Domains
- [ ] Extensions
- [ ] Comments/documentation
- [ ] Dependency management

## Data modeling
- [ ] Entity-relationship modeling
- [ ] Cardinality and optionality
- [ ] Primary/candidate/surrogate/natural keys
- [ ] Foreign keys
- [ ] Referential actions
- [ ] Functional dependencies
- [ ] Normal forms 1NF/2NF/3NF/BCNF
- [ ] Denormalization
- [ ] Update/insert/delete anomalies
- [ ] Temporal data modeling
- [ ] Soft delete
- [ ] Audit columns
- [ ] Multi-tenancy models
- [ ] Polymorphic associations
- [ ] Hierarchical data
- [ ] Graph-like relationships
- [ ] Data retention

## Constraints and correctness
- [ ] NOT NULL
- [ ] UNIQUE
- [ ] PRIMARY KEY
- [ ] FOREIGN KEY
- [ ] CHECK
- [ ] EXCLUDE
- [ ] DEFERRABLE constraints
- [ ] Partial unique indexes
- [ ] Business invariants
- [ ] Application vs database validation
- [ ] Referential integrity
- [ ] Idempotency
- [ ] Duplicate prevention
- [ ] Race-condition-safe constraints

## Transactions and concurrency
- [ ] Transaction boundaries
- [ ] ACID
- [ ] MVCC
- [ ] Snapshots
- [ ] Isolation levels
- [ ] Dirty/non-repeatable/phantom reads
- [ ] Serialization anomalies
- [ ] Row locks
- [ ] Table locks
- [ ] Advisory locks
- [ ] Blocking
- [ ] Deadlocks
- [ ] Deadlock retries
- [ ] Serialization retries
- [ ] Lost updates
- [ ] Optimistic concurrency
- [ ] Pessimistic concurrency
- [ ] Savepoints
- [ ] Two-phase commit
- [ ] Distributed transaction limitations

## Performance
- [ ] Query planner
- [ ] Cost model
- [ ] Cardinality
- [ ] Selectivity
- [ ] Statistics
- [ ] Extended statistics
- [ ] EXPLAIN
- [ ] EXPLAIN ANALYZE
- [ ] BUFFERS
- [ ] I/O timing
- [ ] Sequential scan
- [ ] Index scan
- [ ] Index-only scan
- [ ] Bitmap scan
- [ ] Nested Loop
- [ ] Hash Join
- [ ] Merge Join
- [ ] Sort
- [ ] Hash aggregation
- [ ] Parallel query
- [ ] Partition pruning
- [ ] Predicate pushdown
- [ ] Projection pushdown
- [ ] CTE optimization/materialization
- [ ] JIT considerations
- [ ] Work memory
- [ ] Shared buffers
- [ ] Temp-file spills
- [ ] N+1 queries
- [ ] Sargability
- [ ] Pagination
- [ ] Keyset pagination
- [ ] Index maintenance
- [ ] Table/index bloat
- [ ] Vacuum/Analyze
- [ ] Autovacuum
- [ ] Query timeouts

## Indexing
- [ ] B-tree
- [ ] Hash
- [ ] GIN
- [ ] GiST
- [ ] SP-GiST
- [ ] BRIN
- [ ] Multicolumn indexes
- [ ] Column order
- [ ] Partial indexes
- [ ] Expression indexes
- [ ] Covering/INCLUDE indexes
- [ ] Unique indexes
- [ ] Index selectivity
- [ ] Index write cost
- [ ] Over-indexing
- [ ] Concurrent index creation
- [ ] Index rebuild/maintenance

## PostgreSQL architecture
- [ ] Server, database, schema and session hierarchy
- [ ] Backend processes
- [ ] Shared buffers
- [ ] WAL
- [ ] Checkpoints
- [ ] Background writer
- [ ] Autovacuum workers
- [ ] Visibility map
- [ ] Free-space map
- [ ] Heap pages and row versions
- [ ] TOAST
- [ ] Transaction IDs
- [ ] Freeze/vacuum
- [ ] Configuration hierarchy
- [ ] Extensions

## Reliability and recovery
- [ ] Logical backups
- [ ] Physical backups
- [ ] WAL archiving
- [ ] Point-in-time recovery
- [ ] Restore testing
- [ ] RPO
- [ ] RTO
- [ ] Replication
- [ ] Replication lag
- [ ] Read replicas
- [ ] Failover
- [ ] High availability
- [ ] Disaster recovery
- [ ] Split-brain risks
- [ ] Backup retention
- [ ] Recovery drills

## Security
- [ ] Authentication
- [ ] Authorization
- [ ] Roles
- [ ] Role inheritance
- [ ] GRANT/REVOKE
- [ ] Default privileges
- [ ] Least privilege
- [ ] RLS
- [ ] SECURITY DEFINER
- [ ] SECURITY INVOKER
- [ ] search_path security
- [ ] Parameterized queries
- [ ] SQL injection
- [ ] TLS
- [ ] Encryption at rest
- [ ] Secret management
- [ ] Audit logging
- [ ] Sensitive-data masking
- [ ] Data retention/deletion requirements

## Data engineering and analytics
- [ ] OLTP
- [ ] OLAP
- [ ] ETL
- [ ] ELT
- [ ] Batch processing
- [ ] Streaming concepts
- [ ] CDC
- [ ] Staging tables
- [ ] Incremental loading
- [ ] Full loading
- [ ] Watermarks
- [ ] Late-arriving data
- [ ] Deduplication
- [ ] Data quality
- [ ] Data profiling
- [ ] Lineage
- [ ] Fact tables
- [ ] Dimension tables
- [ ] Grain
- [ ] Star schema
- [ ] Snowflake schema
- [ ] Slowly changing dimensions
- [ ] Cohort analysis
- [ ] Retention analysis

## Distributed systems
- [ ] Eventual consistency
- [ ] Strong consistency
- [ ] Read-after-write
- [ ] Distributed transactions
- [ ] Saga
- [ ] Compensation
- [ ] Outbox
- [ ] Inbox
- [ ] Idempotent consumers
- [ ] Exactly-once business effect
- [ ] Retry safety
- [ ] Message deduplication

## Application/database integration
- [ ] Connection pools
- [ ] Pool sizing
- [ ] Prepared statements
- [ ] Statement timeouts
- [ ] Lock timeouts
- [ ] Retry strategy
- [ ] Transaction scope in application code
- [ ] ORM-generated SQL
- [ ] Lazy/eager loading
- [ ] N+1 detection
- [ ] API pagination
- [ ] API consistency requirements

## Production operations
- [ ] Slow query investigation
- [ ] Blocking investigation
- [ ] Deadlock investigation
- [ ] CPU pressure
- [ ] Memory pressure
- [ ] I/O pressure
- [ ] Connection exhaustion
- [ ] Long-running transactions
- [ ] Idle-in-transaction sessions
- [ ] Bloat investigation
- [ ] Replication lag investigation
- [ ] Capacity planning
- [ ] Monitoring
- [ ] Alerting
- [ ] Query fingerprints
- [ ] Change management
- [ ] Schema migrations
- [ ] Expand-and-contract migrations
- [ ] Backfills
- [ ] Rollback plans
- [ ] Incident response
- [ ] Root-cause analysis
- [ ] Post-incident prevention

## Expert PostgreSQL topics to add when needed
- [ ] Partitioning strategies and partition-wise joins/aggregates
- [ ] Foreign data wrappers
- [ ] Logical decoding
- [ ] Replication slots and slot retention
- [ ] Publication/subscription design
- [ ] Generated columns
- [ ] Exclusion constraints
- [ ] Temporal/range modeling
- [ ] Full-text search internals
- [ ] JSONB operator classes
- [ ] PostGIS/geospatial concepts
- [ ] Advanced extensions
- [ ] Parallelism and worker limits
- [ ] Planner configuration
- [ ] Custom statistics targets
- [ ] Query plan regression testing

## Learning rule

A concept is not complete in this repository until the learner can answer:

**What is it? → Why does it exist? → When should I use it? → When should I avoid it? → What happens internally? → What are the edge cases? → How does it affect performance? → How does concurrency affect it? → What are the security implications? → How do I troubleshoot it in production?**
