# SQL 101 Curriculum Matrix

This page keeps the repository aligned with the core learning sequence represented by the reference **SQL-101** curriculum while preserving original material and the repository's broader PostgreSQL/production focus.

> The reference curriculum is organized around installation, SQL introduction, querying, modification, data types/constraints, relationships/joins, aggregation, subqueries/views, indexing/performance, transactions/concurrency, advanced topics, best practices, resources, and exercises. This repository implements those areas and then continues into expert and production topics.

| SQL 101 area | This repository | Coverage |
|---|---|---|
| 1. Installation Guide | `00-installation/`, `INSTALLATION.md`, `DOWNLOAD-AND-SETUP.md` | PostgreSQL-first setup plus MySQL/SQLite guidance |
| 2. Introduction to SQL | `01-beginner/`, `CORE-CONCEPTS.md`, `SQL-THEORY.md` | relational model, SQL statements, mental model |
| 3. Querying Data | `01-beginner/04-select.sql`, `05-where.sql`, `06-order-by.sql` | SELECT, filtering, sorting, DISTINCT, LIMIT |
| 4. Modifying Data | `01-beginner/03-insert.sql`, `07-update.sql`, `08-delete.sql` | INSERT, UPDATE, DELETE and safe writes |
| 5. Data Types & Constraints | `01-beginner/02-create-tables.sql`, `13-data-types-and-constraints.sql` | types, PK, FK, UNIQUE, CHECK, NOT NULL, DEFAULT |
| 6. Joins & Relationships | `01-beginner/14-keys-and-relationships.sql`, `02-intermediate/01-joins.sql` | 1:1, 1:N, N:M, JOIN variants |
| 7. Aggregation & Grouping | `02-intermediate/02-group-by.sql`, `03-having.sql` | COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING |
| 8. Subqueries & Views | `02-intermediate/04-subqueries.sql`, `03-advanced/04-views.sql` | subqueries, correlated patterns, views, materialized views |
| 9. Indexing & Performance | `06-performance/`, `11-expert-sql/` | indexes, EXPLAIN, planner behavior, optimization |
| 10. Transactions & Concurrency | `05-transactions/`, `09-real-world-scenarios/deadlock.md` | ACID, isolation, locks, deadlocks, retries |
| 11. Advanced Topics | `03-advanced/`, `11-expert-sql/` | CTEs, recursion, windows, functions, procedures, triggers, JSONB |
| 12. Best Practices | `01-beginner/11-sql-best-practices.sql`, security/performance modules | safe SQL, maintainability, correctness and production practices |
| 13. Learning Resources | `LEARNING-RESOURCES.md` | official docs and practice platforms |
| 14. Exercises & Solutions | `EXERCISES-AND-SOLUTIONS.md`, stage challenges | beginner → production/interview practice |
| Production operations extension | `14-production-operations/` | backups/recovery, monitoring, incident runbooks and RCA |
| PostgreSQL reference extension | `15-postgresql-internals/` through `40-final-production-lab/` | internals, HA/DR, migrations, advanced types, JSON, administration, observability, testing, PG18, reliability, CDC, search, temporal modeling and production simulation |
| Runnable lab extension | `41-runnable-labs/` | executable locks/queues, notifications, materialized views, bulk load, timezone/collation, partitions, RLS and query statistics |
| Production pattern extension | `42-production-patterns/` | pooling, schema drift, performance regression and backup verification |

## Recommended learner route

```text
Install
  ↓
SQL mental model
  ↓
SELECT → WHERE → ORDER BY
  ↓
INSERT → UPDATE → DELETE
  ↓
Data types → constraints → keys
  ↓
JOINs → aggregation → subqueries
  ↓
Views → indexes → transactions
  ↓
CTEs → windows → procedures/triggers
  ↓
Performance → security → production
  ↓
Banking project → interview scenarios → expert SQL
```

## Cross-database note

The learning sequence uses PostgreSQL as the primary executable dialect so examples can be run consistently. SQL concepts are transferable to MySQL, SQLite and other relational systems, but syntax and engine behavior can differ. PostgreSQL-specific lessons are clearly positioned as such.

## Quality standard

Each important topic should provide, where practical:

1. Definition
2. Purpose
3. Mental model
4. Runnable example
5. Expected result
6. Common mistakes
7. Edge cases
8. Performance implications
9. Security/concurrency implications
10. Practice challenge
11. Production usage

## Original-content policy

This matrix is an original navigation and coverage map. It does not reproduce the reference repository's PDFs or copy its lesson text.

| 41. Runnable labs | `41-runnable-labs/` | PostgreSQL operational SQL labs |
| 42. Production patterns | `42-production-patterns/` | pooling, schema drift, backup verification |
| 43. Validation and automation | `43-validation-and-automation/` | manifests, safety, versioning, test runner |
| 44. Advanced production SQL | `44-advanced-production-sql/` | production-grade PostgreSQL query patterns |
| 45. PostgreSQL CI | `45-ci-postgresql/` | Docker, fixtures, assertions, CI |
| 46. Client integration | `46-database-client-integration/` | application/database boundaries |
| 47. Advanced concurrency | `47-advanced-concurrency/` | isolation, locks, retries, MVCC |
| 48. Data loading/export | `48-data-loading-and-export/` | bulk data movement and validation |
| 49. Recovery/migration drills | `49-recovery-and-migration-drills/` | backup, restore, PITR, migration rehearsal |
| 50. Logical replication | `50-logical-replication-lab/` | publisher/subscriber and monitoring |
| 51. SQL quality | `51-sql-quality-and-linting/` | linting, style, safety gates |
| 52. Observability/performance | `52-observability-and-performance-lab/` | plans, waits, statistics and baselines |

| 53. Completeness Audit | `53-completeness-audit/` | reproducibility, replication restrictions, version checks and acceptance criteria |
| 54. Multi-Session & Cluster Labs | `54-multi-session-and-cluster-labs/` | concurrency, logical replication and backup/restore harnesses |
| 55. Production Failure & Chaos Labs | `55-production-failure-and-chaos-labs/` | safe failure drills, recovery evidence, incident response and RCA |
| 56. Physical Replication & Major Upgrade | `56-physical-replication-and-upgrade-lab/` | primary/standby, failover, lag and major-upgrade rehearsal |
| 57. Runnable Client Integration Labs | `57-client-integration-runnable-labs/` | Python, Java JDBC and Node.js integration patterns |
| 58. PostgreSQL 18 Operational Tools | `58-postgresql-18-operational-tools/` | integrity, backup verification, benchmarking and operational tooling |

| 59. SQL Error Diagnostics | `59-sql-error-diagnostics/` | SQLSTATE, PL/pgSQL exception diagnostics and retry classification |
| 60. PostGIS & Geospatial SQL | `60-postgis-geospatial/` | optional spatial data, SRIDs, distance, indexing and quality |
| 61. PostgreSQL Testing & Server Programming | `61-postgresql-testing-and-server-programming/` | regression tests, isolation/concurrency tests, recovery/replication test strategy and server-side programming boundaries |
| 62. Advanced PostgreSQL Internals & Interfaces | `62-postgresql-advanced-internals-and-interfaces/` | JIT, catalogs, protocol, libpq, FDW, sampling, access/extension interfaces and portability |
