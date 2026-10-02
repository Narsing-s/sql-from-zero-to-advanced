# SQL Missing Concepts & Completeness Checklist

This is the repository's **master curriculum audit**. It covers language semantics, relational theory, PostgreSQL internals, design, security, analytics, distributed systems and production operations.

> A checked concept should have **definition + purpose + mental model + example + edge cases + performance + security/concurrency + production guidance** somewhere in the repository.

## 1. SQL foundations and relational theory
- [x] SQL language and declarative programming
- [x] SQL standard vs PostgreSQL dialect
- [ ] relational model
- [ ] relation, tuple, attribute, domain
- [ ] keys and functional dependencies
- [ ] relational algebra
- [ ] selection, projection, join, union, difference
- [ ] SQL bag/multiset semantics
- [ ] duplicate rows and row multiplication
- [ ] NULL and three-valued logic
- [ ] type systems and implicit coercion
- [ ] explicit CAST
- [ ] collation
- [ ] encoding/character sets
- [ ] deterministic vs nondeterministic ordering
- [ ] data type precedence
- [ ] numeric precision, scale, rounding and overflow
- [ ] date/time/timestamp/timezone semantics
- [ ] interval and temporal arithmetic
- [ ] boolean semantics
- [ ] UUID
- [ ] arrays
- [ ] composite/record values
- [ ] domains
- [ ] enums
- [ ] range and multirange types

## 2. SQL query language
- [ ] SELECT
- [ ] FROM
- [ ] table expressions
- [ ] WHERE
- [ ] GROUP BY
- [ ] HAVING
- [ ] ORDER BY
- [ ] LIMIT/OFFSET
- [ ] DISTINCT
- [ ] DISTINCT ON
- [ ] aliases
- [ ] expressions
- [ ] predicates
- [ ] literals
- [ ] parameters
- [ ] operator precedence
- [ ] CASE
- [ ] COALESCE
- [ ] NULLIF
- [ ] LIKE/ILIKE
- [ ] regex
- [ ] IN/NOT IN
- [ ] EXISTS/NOT EXISTS
- [ ] ANY/SOME
- [ ] ALL
- [ ] BETWEEN
- [ ] JOIN variants
- [ ] CROSS JOIN
- [ ] self joins
- [ ] LATERAL
- [ ] subqueries
- [ ] correlated subqueries
- [ ] UNION
- [ ] UNION ALL
- [ ] INTERSECT
- [ ] EXCEPT
- [ ] recursive queries
- [ ] SEARCH/CYCLE concepts
- [ ] query logical processing order

## 3. Aggregation and analytics
- [ ] COUNT
- [ ] SUM
- [ ] AVG
- [ ] MIN/MAX
- [ ] scalar vs aggregate functions
- [ ] FILTER
- [ ] ordered aggregates
- [ ] GROUPING SETS
- [ ] ROLLUP
- [ ] CUBE
- [ ] window functions
- [ ] PARTITION BY
- [ ] window ORDER BY
- [ ] window frames
- [ ] ROWS/RANGE/GROUPS
- [ ] named windows
- [ ] ROW_NUMBER
- [ ] RANK
- [ ] DENSE_RANK
- [ ] LAG/LEAD
- [ ] FIRST_VALUE/LAST_VALUE
- [ ] running totals
- [ ] moving averages
- [ ] percentiles
- [ ] ordered-set aggregates

## 4. Data modification
- [ ] INSERT
- [ ] multi-row INSERT
- [ ] INSERT ... SELECT
- [ ] UPDATE
- [ ] DELETE
- [ ] RETURNING
- [ ] UPSERT / ON CONFLICT
- [ ] MERGE
- [ ] bulk writes
- [ ] safe UPDATE/DELETE
- [ ] affected-row verification
- [ ] write amplification
- [ ] trigger side effects
- [ ] retry-safe writes

## 5. DDL and database objects
- [ ] CREATE/ALTER/DROP
- [ ] database
- [ ] schema
- [ ] table
- [ ] sequence
- [ ] identity column
- [ ] temporary table
- [ ] unlogged table
- [ ] view
- [ ] materialized view
- [ ] function
- [ ] procedure
- [ ] trigger
- [ ] generated column
- [ ] domain
- [ ] enum
- [ ] extension
- [ ] comments/documentation
- [ ] object dependencies
- [ ] ownership
- [ ] dependency-aware migrations

## 6. Data modeling and normalization
- [ ] entity
- [ ] attribute
- [ ] relationship
- [ ] cardinality
- [ ] optionality
- [ ] ERD
- [ ] logical model
- [ ] physical model
- [ ] row grain
- [ ] candidate key
- [ ] primary key
- [ ] natural key
- [ ] surrogate key
- [ ] foreign key
- [ ] referential actions
- [ ] functional dependency
- [ ] 1NF
- [ ] 2NF
- [ ] 3NF
- [ ] BCNF
- [ ] denormalization
- [ ] insertion/update/deletion anomalies
- [ ] polymorphic associations
- [ ] temporal models
- [ ] soft delete
- [ ] audit columns
- [ ] multi-tenancy
- [ ] hierarchical data
- [ ] graph-like relationships
- [ ] retention policies

## 7. Constraints and correctness
- [ ] NOT NULL
- [ ] UNIQUE
- [ ] PRIMARY KEY
- [ ] FOREIGN KEY
- [ ] CHECK
- [ ] EXCLUDE
- [ ] DEFERRABLE constraints
- [ ] partial unique indexes
- [ ] business invariants
- [ ] database vs application validation
- [ ] referential integrity
- [ ] idempotency
- [ ] duplicate prevention
- [ ] race-condition-safe constraints
- [ ] canonical-record selection

## 8. Transactions and concurrency
- [ ] transaction boundary
- [ ] ACID
- [ ] COMMIT
- [ ] ROLLBACK
- [ ] SAVEPOINT
- [ ] MVCC
- [ ] snapshots
- [ ] transaction IDs
- [ ] visibility
- [ ] Read Committed
- [ ] Repeatable Read
- [ ] Serializable
- [ ] dirty reads
- [ ] non-repeatable reads
- [ ] phantom reads
- [ ] lost updates
- [ ] write skew
- [ ] serialization anomalies
- [ ] row locks
- [ ] table locks
- [ ] lock modes
- [ ] advisory locks
- [ ] blocking
- [ ] deadlocks
- [ ] deadlock retries
- [ ] serialization retries
- [ ] optimistic concurrency
- [ ] pessimistic concurrency
- [ ] atomic conditional UPDATE
- [ ] two-phase commit
- [ ] distributed transaction limitations

## 9. Query planning and optimization
- [ ] query planner
- [ ] optimizer
- [ ] cost model
- [ ] cardinality estimates
- [ ] selectivity
- [ ] statistics
- [ ] histograms
- [ ] most-common values
- [ ] extended statistics
- [ ] EXPLAIN
- [ ] EXPLAIN ANALYZE
- [ ] BUFFERS
- [ ] I/O timing
- [ ] sequential scan
- [ ] index scan
- [ ] index-only scan
- [ ] bitmap scan
- [ ] nested loop
- [ ] hash join
- [ ] merge join
- [ ] sort
- [ ] hash aggregation
- [ ] parallel query
- [ ] predicate pushdown
- [ ] projection pushdown
- [ ] join ordering
- [ ] CTE optimization/materialization
- [ ] JIT
- [x] work_mem
- [ ] shared_buffers
- [ ] temp-file spills
- [ ] sargability
- [ ] N+1
- [ ] pagination
- [ ] keyset pagination
- [ ] query cancellation
- [ ] statement timeout
- [ ] lock timeout
- [ ] plan regression testing

## 10. Indexing
- [ ] B-tree
- [ ] Hash
- [x] GIN
- [x] GiST
- [x] SP-GiST
- [x] BRIN
- [ ] multicolumn indexes
- [ ] column order
- [ ] selectivity
- [ ] partial indexes
- [ ] expression indexes
- [ ] covering/INCLUDE indexes
- [ ] unique indexes
- [ ] index-only scans
- [ ] index write cost
- [ ] over-indexing
- [ ] concurrent index creation
- [ ] index bloat
- [ ] index rebuild/maintenance

## 11. PostgreSQL architecture and internals
- [ ] server/database/schema/session hierarchy
- [ ] backend processes
- [ ] shared buffers
- [ ] WAL
- [ ] checkpoints
- [ ] background writer
- [ ] WAL writer
- [ ] autovacuum workers
- [ ] heap pages
- [ ] tuple versions
- [ ] visibility map
- [ ] free-space map
- [ ] TOAST
- [ ] transaction IDs
- [ ] freezing
- [ ] configuration hierarchy
- [ ] extensions
- [ ] system catalogs

## 12. Vacuum and maintenance
- [ ] VACUUM
- [ ] VACUUM FULL
- [ ] ANALYZE
- [ ] autovacuum
- [ ] autoanalyze
- [ ] dead tuples
- [ ] bloat
- [ ] long-running transactions
- [ ] idle-in-transaction sessions
- [ ] transaction ID wraparound
- [x] maintenance_work_mem
- [ ] visibility map and vacuum interaction

## 13. Security
- [ ] authentication
- [ ] authorization
- [ ] roles
- [ ] role membership/inheritance
- [ ] GRANT
- [ ] REVOKE
- [ ] default privileges
- [ ] ownership
- [ ] least privilege
- [ ] RLS
- [ ] SECURITY DEFINER
- [ ] SECURITY INVOKER
- [ ] search_path security
- [ ] parameterized queries
- [ ] SQL injection
- [ ] TLS
- [ ] encryption at rest
- [ ] secret management
- [ ] audit logging
- [ ] sensitive-data masking
- [ ] retention/deletion
- [ ] threat modeling

## 14. JSON, search and specialized PostgreSQL
- [ ] JSON vs JSONB
- [ ] JSON operators
- [ ] JSON path
- [ ] JSONB indexing
- [ ] GIN operator classes
- [ ] generated columns
- [ ] full-text search
- [ ] tsvector
- [ ] tsquery
- [ ] ranking
- [ ] range operators
- [ ] exclusion constraints
- [ ] arrays and array operators
- [ ] foreign data wrappers
- [x] PostGIS/geospatial concepts
- [x] PostGIS/geospatial hands-on lab

## 15. Partitioning
- [ ] RANGE
- [ ] LIST
- [ ] HASH
- [ ] partition key
- [ ] partition pruning
- [ ] partition maintenance
- [ ] partition-wise joins
- [ ] partition-wise aggregation
- [ ] default partitions
- [ ] attach/detach operations
- [ ] partition indexes
- [ ] partition migration

## 16. Reliability and recovery
- [ ] logical backups
- [ ] physical backups
- [ ] WAL archiving
- [ ] PITR
- [ ] restore testing
- [ ] RPO
- [ ] RTO
- [ ] replication
- [ ] physical replication
- [ ] logical replication
- [ ] replication lag
- [ ] read replicas
- [ ] failover
- [ ] high availability
- [ ] disaster recovery
- [ ] split-brain risk
- [ ] replication slots
- [ ] slot retention
- [ ] backup retention
- [ ] recovery drills

## 17. Data engineering and analytics
- [ ] OLTP
- [ ] OLAP
- [ ] ETL
- [ ] ELT
- [ ] batch processing
- [ ] streaming concepts
- [ ] CDC
- [ ] logical decoding
- [ ] staging
- [ ] full loads
- [ ] incremental loads
- [ ] watermarks
- [ ] late-arriving data
- [ ] deduplication
- [ ] data profiling
- [ ] data quality
- [ ] lineage
- [ ] fact tables
- [ ] dimensions
- [ ] grain
- [ ] star schema
- [ ] snowflake schema
- [ ] SCD
- [ ] cohort analysis
- [ ] retention analysis

## 18. Distributed systems
- [ ] strong consistency
- [ ] eventual consistency
- [ ] read-after-write
- [ ] distributed transactions
- [ ] two-phase commit
- [ ] Saga
- [ ] compensation
- [ ] outbox
- [ ] inbox
- [ ] idempotent consumers
- [ ] at-least-once delivery
- [ ] exactly-once business effect
- [ ] retries
- [ ] message deduplication
- [ ] ordering

## 19. Application/database integration
- [ ] connection pools
- [ ] pool sizing
- [ ] pool exhaustion
- [x] prepared statements
- [x] generic/custom plans
- [ ] ORM-generated SQL
- [ ] lazy/eager loading
- [ ] N+1 detection
- [ ] statement timeouts
- [ ] lock timeouts
- [ ] transaction scope
- [ ] retry strategy
- [ ] API pagination
- [ ] API consistency requirements
- [ ] correlation/request IDs

## 20. Schema evolution and migrations
- [ ] migration versions
- [ ] dependency ordering
- [ ] expand-and-contract
- [ ] backward-compatible schema changes
- [ ] backfills
- [ ] batched backfills
- [ ] resumable backfills
- [ ] zero-downtime migrations
- [ ] lock impact
- [ ] replication impact
- [ ] rollback strategy
- [ ] forward-fix strategy
- [ ] schema compatibility

## 21. Production operations
- [ ] slow query investigation
- [ ] blocking investigation
- [ ] deadlock investigation
- [ ] CPU pressure
- [ ] memory pressure
- [ ] I/O pressure
- [ ] connection exhaustion
- [ ] long-running transactions
- [ ] idle-in-transaction
- [ ] bloat investigation
- [ ] replication lag
- [ ] capacity planning
- [ ] monitoring
- [ ] alerting
- [ ] query fingerprints
- [ ] change management
- [ ] incident response
- [ ] RCA
- [ ] post-incident prevention
- [ ] performance regression testing

## 22. Advanced PostgreSQL topics
- [ ] logical decoding
- [ ] publication/subscription design
- [ ] replication slots
- [ ] partition-wise joins
- [ ] partition-wise aggregates
- [ ] planner configuration
- [ ] custom statistics targets
- [ ] advanced extensions
- [ ] FDW
- [ ] PostGIS
- [ ] parallelism and worker limits
- [ ] plan cache behavior
- [ ] parameter-sensitive planning
- [ ] query plan stability
- [ ] advanced lock monitoring

## Mastery rule

A concept is complete only when the learner can answer:

**What is it? → Why does it exist? → What problem does it solve? → When should I use it? → When should I avoid it? → What happens internally? → What are the edge cases? → How does it affect performance? → How does concurrency affect it? → What are the security implications? → How do I troubleshoot it in production?**

## Implementation rule

This checklist is intentionally broader than one SQL file. Concepts should be distributed across theory documents, runnable SQL, exercises, projects, scenarios and interview material. Do not add a query without explaining the concept behind it.


## 23. Newly audited execution-depth gaps
The broad topic coverage is now supplemented by dedicated runnable/operational material:
- [x] advisory locks and SKIP LOCKED worker queues
- [x] LISTEN/NOTIFY boundaries
- [x] materialized-view concurrent refresh
- [x] COPY bulk-loading workflow
- [x] timezone/DST and collation exercises
- [x] partition lifecycle/pruning exercise
- [x] RLS tenant-isolation lab
- [x] pg_stat_statements query-statistics lab
- [x] connection-pool production checklist
- [x] schema-drift and performance-regression checklist
- [x] backup verification and restore-drill procedure
- [x] recursive SEARCH/CYCLE execution lab
- [x] concurrent index maintenance guidance including REINDEX CONCURRENTLY
- [x] production failure/chaos drill matrix
- [x] incident response and RCA evidence template
- [x] CLUSTER / VACUUM FULL progress monitoring (`pg_stat_progress_cluster`)
- [x] replication-origin progress tracking (`pg_replication_origin_status`)

### Remaining validation rule
Coverage alone is not enough. A module should be promoted to complete only after its SQL is executable on the documented PostgreSQL version, has setup/cleanup instructions, expected observations, and a verification step. Theory-only material should remain explicitly labeled as theory.


## 18. Automated verification and engineering practice
- [ ] deterministic PostgreSQL fixtures
- [ ] executable SQL assertions
- [ ] GitHub Actions database tests
- [ ] repository structure audit
- [ ] safe vs destructive lab classification
- [ ] multi-session isolation harness
- [ ] backup/restore rehearsal
- [ ] logical replication lab
- [ ] SQL linting/style
- [ ] reproducible performance baselines
- [ ] workload/version/schema metadata captured with benchmarks

## 19. Application integration
- [ ] JDBC transaction boundaries
- [ ] psycopg transaction handling
- [ ] node-postgres pooling
- [x] prepared statements
- [ ] parameter binding
- [ ] retryable serialization/deadlock failures
- [ ] idempotency
- [ ] cursor/streaming patterns
- [ ] application timeout hierarchy


## 20. Final audit
- [ ] deterministic locale/timezone assertions
- [ ] extension/version audit
- [ ] logical replication restrictions documented
- [x] replication-origin concepts covered
- [x] PostgreSQL 18 recovery-prefetch and WAL-archiver observability
- [x] PostgreSQL 18 per-backend I/O/WAL statistics
- [x] PostgreSQL 18 maintenance timing and lock-failure observability
- [ ] reproducibility metadata captured
- [ ] curriculum acceptance criteria documented


## Stage 61 — PostgreSQL Testing & Server Programming
- [x] Regression testing concepts and deterministic expected-output validation
- [x] Concurrent/isolation testing strategy
- [x] Recovery and physical-replication test strategy
- [x] Logical-replication test strategy
- [x] Database CI test-quality and failure taxonomy
- [x] PL/pgSQL/server-side programming boundaries
- [x] Trigger and event-trigger testing considerations
- [x] Logical decoding/CDC testing considerations
- [x] PostgreSQL extension testing and upgrade considerations
- [x] Archive-module theory coverage
- [x] OAuth validator module theory and security testing coverage
- [x] 50 testing/server-programming interview scenarios with answers


## Stage 62 — Advanced PostgreSQL Internals & Interfaces
- [x] PostgreSQL planner/executor theory
- [x] JIT compilation and workload trade-offs
- [x] system catalogs vs information_schema
- [x] frontend/backend protocol concepts
- [x] libpq/client connection concepts
- [x] large-object theory
- [x] ECPG theory
- [x] FDW and predicate pushdown
- [x] TABLESAMPLE theory
- [x] custom scan provider theory
- [x] table access method theory
- [x] SPI/server programming interface theory
- [x] SQL standard conformance and portability
- [x] advanced authentication/OAuth client-server concepts
- [x] 50 advanced internals theory questions
- [x] 40 advanced production scenario questions


## 24. Stage 63 deep internals/extensibility audit
- [x] parser → analyzer → rewrite → planner → executor lifecycle
- [x] query rewrite/rule system versus triggers
- [x] MVCC snapshots, XID wraparound, visibility map, free-space map and TOAST theory
- [x] WAL/checkpoint/crash-recovery internals
- [x] extension WAL and crash-safety concepts
- [x] procedural-language handlers and validators
- [x] SPI and memory-context considerations
- [x] FDW predicate pushdown and semantic-safety scenarios
- [x] TABLESAMPLE/custom scan/table-access-method concepts
- [x] custom data types and operator/index semantics
- [x] logical replication architecture and PostgreSQL 18 failover theory/scenarios
- [x] MERGE candidate classification, WHEN ordering, RETURNING and merge_action()
- [x] 50 advanced theory Q&As
- [x] 40 advanced production scenario Q&As

> This stage is intentionally theory/scenario focused. It does not claim that every C-level PostgreSQL extension interface is runnable from ordinary SQL; such interfaces require compiled extension code and version-specific development environments.
