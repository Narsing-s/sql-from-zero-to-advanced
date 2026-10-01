# SQL From Zero to Advanced 🚀

Welcome to a **theory-first, practical SQL learning journey**.

This repository is designed for someone who may be completely new to SQL. **Do not read the queries as magic syntax.** Learn the concepts, definitions and mental models first, then use SQL examples to prove the concepts by running them.

## 📚 Complete Theory Library

### 1. SQL Theory — concept explanations
**[SQL-THEORY.md](SQL-THEORY.md)**

Covers the complete journey from SQL foundations to production engineering:
- database and relational theory
- SQL command families
- SELECT logical processing
- filtering, NULL and three-valued logic
- joins and aggregation
- keys, constraints and normalization
- subqueries, CTEs and recursion
- window functions
- views, functions, procedures and triggers
- transactions, ACID, locks and isolation
- indexes and query plans
- partitioning
- JSON/JSONB
- UPSERT/MERGE
- security and RLS
- full-text search and LATERAL
- OLTP/OLAP
- pooling, WAL, backups and replication
- production troubleshooting

### 2. Core Concepts — definitions from A to Z
**[CORE-CONCEPTS.md](CORE-CONCEPTS.md)**

This is the **SQL dictionary + theory reference**. It defines 180 core terms including:

- Database / DBMS / RDBMS
- schema, table, row, column and data type
- entities and relationships
- cardinality
- primary/candidate/natural/surrogate keys
- foreign keys and referential integrity
- constraints and indexes
- sequences and identity columns
- views and materialized views
- functions, procedures and triggers
- transactions and ACID
- NULL and three-valued logic
- SELECT, WHERE, GROUP BY, HAVING, ORDER BY
- predicates, expressions and operators
- joins and set operations
- aggregate and window functions
- subqueries and CTEs
- normalization and functional dependency
- concurrency, MVCC, locks and deadlocks
- isolation levels and anomalies
- query planner, plans, scans, statistics and selectivity
- partitions and replication
- backups, RPO and RTO
- authentication, authorization and privileges
- RLS and SQL injection
- OLTP, OLAP, ETL and ELT
- data pipelines and slowly changing dimensions
- connection pools and production readiness

### 3. Advanced & Expert Theory
**[ADVANCED-EXPERT-THEORY.md](ADVANCED-EXPERT-THEORY.md)**

Covers advanced PostgreSQL and production engineering concepts including:

- relational algebra
- declarative SQL and query equivalence
- predicate/projection pushdown
- join algorithms
- hash aggregation and sorting
- work memory and shared buffers
- extended statistics
- index-only, partial, expression and covering indexes
- B-tree, Hash, GIN, GiST and BRIN
- MVCC visibility and lock modes
- advisory locks
- deadlock detection
- serialization retry
- optimistic/pessimistic concurrency
- lost-update prevention
- distributed transactions
- eventual consistency
- outbox/inbox patterns
- CDC
- logical/physical replication
- read replicas and replication lag
- high availability and failover
- PITR and WAL archiving
- vacuum, autovacuum and bloat
- prepared statements and plan behavior
- sargability and N+1 queries
- offset/keyset pagination
- bulk loading and staging
- star/snowflake schemas
- facts, dimensions and grain
- data lineage and data quality
- schema evolution and zero-downtime migrations
- backfills and batching
- retry safety and exactly-once business effects
- sagas and compensation
- JSONB, ranges and exclusion constraints
- RLS policies and SECURITY DEFINER
- production query review

## How to learn every concept

Every concept should be understood in this order:

1. **Definition** — what does the term mean?
2. **Purpose** — why does it exist?
3. **Problem** — what problem does it solve?
4. **Mental model** — how should you think about it?
5. **Syntax** — what does it look like?
6. **Example** — see it in action.
7. **Line-by-line explanation** — understand each part.
8. **Expected result** — predict what happens.
9. **Practice** — solve a similar problem.
10. **Edge cases** — understand unusual behavior.
11. **Common mistakes** — learn what can go wrong.
12. **Performance** — understand scale implications.
13. **Security** — understand access and safety implications.
14. **Concurrency** — understand simultaneous execution.
15. **Production use** — connect theory to real systems.
16. **Interview questions** — prove your understanding.

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

```text
Business Requirement
       ↓
Data Model
       ↓
Relational Theory
       ↓
Constraints
       ↓
SQL
       ↓
Execution Plan
       ↓
Performance
       ↓
Concurrency
       ↓
Security
       ↓
Observability
       ↓
Recovery
```

The SQL statement is only one part of the solution.

## Hands-on learning

Use the theory documents together with the numbered SQL exercises:

```text
READ DEFINITION
      ↓
UNDERSTAND THEORY
      ↓
BUILD MENTAL MODEL
      ↓
READ EXAMPLE
      ↓
RUN SQL
      ↓
PREDICT RESULT
      ↓
PRACTICE WITHOUT COPYING
      ↓
SOLVE REAL-WORLD SCENARIO
      ↓
CHECK PERFORMANCE
      ↓
EXPLAIN YOUR SOLUTION
```

## UI

The `web/` folder contains a local-first learning interface. It requires **no API keys, no paid services, and no external authentication provider** for the learner demo.

## Start

1. Read **[SQL-THEORY.md](SQL-THEORY.md)**.
2. Use **[CORE-CONCEPTS.md](CORE-CONCEPTS.md)** as the definition/reference guide.
3. Use **[ADVANCED-EXPERT-THEORY.md](ADVANCED-EXPERT-THEORY.md)** for advanced concepts.
4. Begin with **[00-installation](00-installation/README.md)**.
5. Progress through the numbered folders.
6. Run the SQL examples.
7. Complete the exercises.
8. Build the real-world projects.
9. Use the interview and production-scenario sections to test yourself.

**Goal: understand SQL deeply enough to explain it, write it, troubleshoot it, optimize it and use it safely in production.**
