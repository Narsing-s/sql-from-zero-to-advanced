# SQL From Zero to Advanced 🚀

Welcome to a **theory-first, practical SQL learning journey**.

This repository is designed for someone who may be completely new to SQL. **SQL is not only queries.** Learn the definitions, theory and mental models first, then prove the concepts by running SQL.

## 📚 Complete Theory Library

### 1. Complete SQL Theory
**[COMPLETE-SQL-THEORY.md](COMPLETE-SQL-THEORY.md)**

The single broad theory reference covering:

- SQL and relational foundations
- SQL standard vs PostgreSQL
- bag/multiset semantics
- database, DBMS, RDBMS, schema and session
- data modeling, ERD, cardinality, optionality and grain
- PostgreSQL data types, casting, collation and time zones
- keys, constraints, business invariants and referential integrity
- normalization, functional dependencies and BCNF
- logical query processing
- NULL and three-valued logic
- operators, predicates and set operations
- joins, LATERAL and join multiplication
- subqueries, EXISTS, IN, ANY and ALL
- aggregation, FILTER, GROUPING SETS, ROLLUP and CUBE
- window functions and frames
- CTEs and recursive CTEs
- DDL, DML, DQL, DCL and TCL
- INSERT, UPDATE, DELETE, RETURNING, UPSERT and MERGE
- tables, temporary tables, unlogged tables and generated columns
- views and materialized views
- functions, procedures and triggers
- transactions, ACID, isolation and anomalies
- MVCC, locks, blocking and deadlocks
- query planner, cardinality, statistics and execution plans
- scan and join algorithms
- sargability and query performance
- all major PostgreSQL index families
- pagination and N+1 queries
- PostgreSQL storage internals, WAL, checkpoints and TOAST
- VACUUM, ANALYZE, autovacuum and bloat
- connection pooling and prepared statements
- authentication, authorization, RLS and SQL injection
- auditing and sensitive-data handling
- JSONB and full-text search
- partitioning
- OLTP/OLAP and warehouse modeling
- ETL/ELT, incremental loads, watermarks and data quality
- CDC and logical decoding
- replication, slots, lag and read-after-write consistency
- backups, PITR, RPO, RTO and recovery drills
- distributed transactions, sagas, outbox/inbox and idempotency
- schema evolution and zero-downtime migrations
- production observability and troubleshooting
- temporal data, multi-tenancy, soft delete and hierarchical data
- advanced PostgreSQL and planner-regression topics
- expert SQL review and production engineering

### 2. Core Concepts — definitions
**[CORE-CONCEPTS.md](CORE-CONCEPTS.md)**

Use this as the SQL dictionary/reference for core terminology.

### 3. Advanced & Expert Theory
**[ADVANCED-EXPERT-THEORY.md](ADVANCED-EXPERT-THEORY.md)**

Use this for deeper PostgreSQL internals, optimization, concurrency, distributed systems and production engineering.

### 4. Missing Concepts Checklist
**[MISSING-CONCEPTS-CHECKLIST.md](MISSING-CONCEPTS-CHECKLIST.md)**

A curriculum audit containing additional concepts that should not be forgotten as the repository grows.

### 5. Database Design Extensions
**[04-database-design/BCNF-and-advanced-normalization.md](04-database-design/BCNF-and-advanced-normalization.md)**

Covers BCNF, temporal data, soft delete, multi-tenancy, hierarchical data and retention.

## How to learn every concept

Every concept should be understood in this order:

1. Definition — what does it mean?
2. Purpose — why does it exist?
3. Problem — what problem does it solve?
4. Mental model — how should you think about it?
5. Syntax — what does it look like?
6. Example — see it in action.
7. Line-by-line explanation — understand each part.
8. Expected result — predict what happens.
9. Practice — solve a similar problem.
10. Edge cases — understand unusual behavior.
11. Common mistakes — learn what can go wrong.
12. Performance — understand scale implications.
13. Security — understand access and safety implications.
14. Concurrency — understand simultaneous execution.
15. Production use — connect theory to real systems.
16. Interview questions — prove your understanding.

## Learning path

| Stage | Focus |
|---|---|
| 00 | Installation and database environment |
| 01 | Core SQL foundations and CRUD |
| 02 | JOINs, aggregation, subqueries and business logic |
| 03 | CTEs, recursion, windows, views, functions and triggers |
| 04 | Database design, keys, constraints and normalization |
| 05 | Transactions, ACID, locks and isolation |
| 06 | Indexes, execution plans and performance |
| 07 | Roles, permissions and security |
| 08 | Complete banking database |
| 09 | Production troubleshooting |
| 10 | Interview preparation |
| 11 | Expert PostgreSQL |
| 12 | Data engineering and analytics |
| 13 | Real-world projects |

## The repository philosophy

SQL is **not only queries**.

A professional SQL engineer understands:

Business Requirement
→ Data Model
→ Relational Theory
→ Constraints
→ SQL
→ Execution Plan
→ Performance
→ Concurrency
→ Security
→ Observability
→ Recovery

The SQL statement is only one part of the solution.

## Hands-on learning

READ DEFINITION
→ UNDERSTAND THEORY
→ BUILD MENTAL MODEL
→ READ EXAMPLE
→ RUN SQL
→ PREDICT RESULT
→ PRACTICE WITHOUT COPYING
→ SOLVE REAL-WORLD SCENARIO
→ CHECK PERFORMANCE
→ EXPLAIN YOUR SOLUTION

## UI

The web/ folder contains a local-first learning interface. It requires **no API keys, no paid services and no external authentication provider** for the learner demo.

## Start

1. Read COMPLETE-SQL-THEORY.md.
2. Use CORE-CONCEPTS.md as the definition/reference guide.
3. Use ADVANCED-EXPERT-THEORY.md for deeper concepts.
4. Use MISSING-CONCEPTS-CHECKLIST.md as the curriculum audit.
5. Begin with 00-installation.
6. Progress through the numbered folders.
7. Run the SQL examples.
8. Complete the exercises.
9. Build the real-world projects.
10. Use the interview and production-scenario sections to test yourself.

**Goal: understand SQL deeply enough to explain it, write it, troubleshoot it, optimize it and use it safely in production.**
