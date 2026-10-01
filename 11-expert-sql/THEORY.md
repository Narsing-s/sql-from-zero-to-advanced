# Expert SQL Theory Guide

This guide explains the why behind advanced PostgreSQL features before the learner runs the examples.

## 1. NULL and three-valued logic
SQL has TRUE, FALSE, and UNKNOWN. NULL means a value is missing or unknown. NULL = NULL is not TRUE because two unknown values cannot be proven equal. Use IS NULL, IS NOT NULL, IS DISTINCT FROM, and COALESCE deliberately.

Example:
~~~sql
SELECT customer_id, COALESCE(email, 'missing') FROM beginner.customers;
~~~

## 2. LATERAL
A LATERAL subquery can reference columns from the row on its left. It is powerful for top-N-per-parent problems and correlated lookups.

## 3. DISTINCT ON
PostgreSQL's DISTINCT ON keeps the first row for each key according to ORDER BY. It is concise, but PostgreSQL-specific.

## 4. Conditional aggregation
FILTER lets one aggregate count or sum only matching rows. It often reads more clearly than many CASE expressions.

## 5. JSONB
JSONB stores semi-structured JSON in a binary representation optimized for querying. It is useful when attributes vary, but stable business fields usually belong in normal columns.

## 6. UPSERT
INSERT ... ON CONFLICT makes insert-or-update behavior atomic around a declared unique constraint. It is useful for idempotent ingestion and synchronization.

## 7. MERGE
MERGE describes synchronization between a source relation and target table. It can express matched updates and unmatched inserts in one statement. Always test behavior against the PostgreSQL version used by your system.

## 8. Partitioning
Partitioning divides one logical table into physical partitions. Range partitioning is common for time-series data. The planner can prune irrelevant partitions, but partitioning does not automatically fix poor queries.

## 9. Row-level security
RLS adds row visibility rules at the database layer. It is useful for multi-tenant systems where different users must see different rows. Test policies with dedicated roles.

## 10. Materialized views
A normal view stores a query definition; a materialized view stores results. Materialized views trade freshness and refresh cost for faster repeated reads.

## 11. Full-text search
PostgreSQL full-text search converts text into searchable tokens using tsvector and tsquery. GIN indexes can make large document searches efficient.

## 12. Advisory locks
Advisory locks coordinate application-level work using an integer key. They are useful for preventing duplicate processing of the same logical resource.

## 13. Isolation
Transaction isolation controls what one concurrent transaction can observe from another. Understand READ COMMITTED, REPEATABLE READ, SERIALIZABLE, and the anomalies each level addresses.

## 14. Indexes
An index is an additional data structure that can reduce lookup work. Indexes speed selected reads but consume storage and make writes more expensive. Measure with EXPLAIN (ANALYZE, BUFFERS).

## 15. Query plans
The optimizer chooses a plan based on statistics, estimates, available indexes, join strategies, and costs. Read the plan instead of assuming an index is being used.

## 16. CTE materialization
A CTE can improve readability and can sometimes influence execution. PostgreSQL may inline eligible CTEs. Use MATERIALIZED or NOT MATERIALIZED intentionally when execution behavior matters.

## 17. Window functions
Window functions calculate across related rows without collapsing them like GROUP BY. They are ideal for ranking, running totals, lag/lead comparisons, and period-over-period analysis.

## 18. Recursive CTEs
Recursive CTEs solve hierarchical and graph-like problems such as org charts, category trees, dependency chains, and path traversal. Always design termination conditions.

## 19. Data quality
A production data pipeline should measure null rates, duplicates, invalid references, unexpected ranges, and freshness. A successful SQL statement is not proof that the data is correct.

## 20. Incremental loading
Incremental loads process only new or changed records instead of rebuilding everything. A watermark such as updated_at is common, but late-arriving data and clock precision must be considered.

## 21. Cohort analysis
Cohorts group entities by a meaningful first event, such as signup or first transaction, and measure behavior over later periods. This makes retention and lifecycle analysis comparable.

## 22. Referential integrity
Foreign keys prevent orphaned references. ON DELETE CASCADE, RESTRICT, SET NULL, and SET DEFAULT have very different business consequences; choose them deliberately.

## 23. Constraints as executable business rules
NOT NULL, CHECK, UNIQUE, primary keys, and foreign keys move correctness into the database. Application validation is useful, but database constraints provide the final consistency boundary.

## 24. Idempotency
A retry-safe operation produces the same intended result when repeated. Unique business keys plus UPSERT or transactionally recorded request IDs are common patterns for APIs and message consumers.

## 25. Production troubleshooting
When a query is slow, investigate input size, execution plan, statistics, indexes, locks, I/O, joins, network transfer, and application behavior. Do not jump straight to adding indexes.

## 26. SQL security
Use least privilege, parameterized queries, controlled roles, safe schema ownership, and audited access. Never concatenate untrusted input into SQL.

## 27. Transactions in banking
A transfer is not two independent updates. Debit, credit, validation, and audit work should be designed as one atomic unit where business rules require it.

## 28. Auditability
Critical systems should retain who changed what, when, and why. Audit tables should be designed for trustworthy timestamps and immutable event history where required.

## 29. Normalization vs performance
Normalization reduces update anomalies and duplicated facts. Controlled denormalization can improve read performance, but it introduces synchronization responsibility. Measure before denormalizing.

## 30. The production mindset
Expert SQL is not only syntax. It combines correctness, concurrency, data modeling, performance, security, observability, recoverability, and maintainability.
