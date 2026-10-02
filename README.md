# SQL From Zero to Advanced 🚀

A **theory-first, hands-on SQL learning repository** that takes you from absolute beginner to advanced PostgreSQL, production troubleshooting, data engineering, and interview preparation.

> **SQL is not only queries.** Learn the definition, purpose, mental model, syntax, execution behavior, performance, concurrency, security, and production implications — then prove the concept by running SQL.

## ✨ What this repository covers

This repository combines the beginner-friendly learning style of a SQL 101 course with a much deeper, production-oriented PostgreSQL curriculum.

- 🟢 SQL fundamentals and CRUD
- 🔗 JOINs and relationships
- 📊 Aggregation, GROUP BY and HAVING
- 🧩 Subqueries, EXISTS, IN, ANY and ALL
- 🧠 CASE expressions, NULL and three-valued logic
- 🧱 DDL, DML, DQL, DCL and TCL
- 🔄 Transactions, ACID, isolation, locks and deadlocks
- 🪟 Window functions and window frames
- 🔁 CTEs and recursive CTEs
- 👁️ Views and materialized views
- ⚙️ Functions, procedures and triggers
- 🗃️ Database design, normalization and BCNF
- 🚀 Indexes, EXPLAIN, planner behavior and performance
- 🔐 Roles, permissions, RLS and SQL injection prevention
- 🧾 JSON/JSONB and full-text search
- 🧩 Partitioning and PostgreSQL-specific features
- 🏦 Complete banking project
- 🛠️ Real-world production scenarios
- 💼 SQL interview preparation
- 📈 Data engineering, ETL/ELT, incremental loads and data quality
- 🧪 Practical exercises and challenge-driven learning
- 🖥️ Optional local SQL Learning Hub UI
- 🐳 Optional Docker environment

## 🧭 Learning path

| Stage | Topic |
|---|---|
| 00 | Installation, PostgreSQL, psql, pgAdmin and verification |
| 01 | Beginner SQL: databases, tables, INSERT, SELECT, WHERE, ORDER BY, UPDATE, DELETE, NULL and best practices |
| 02 | Intermediate SQL: JOINs, aggregation, subqueries, CASE, set operations and predicates |
| 03 | Advanced SQL: CTEs, recursion, windows, views, functions, procedures and triggers |
| 04 | Database design, relationships, keys, constraints, normalization and BCNF |
| 05 | Transactions, ACID, isolation, locking and concurrency |
| 06 | Indexes, EXPLAIN and query-performance engineering |
| 07 | Database security |
| 08 | End-to-end banking project |
| 09 | Production troubleshooting scenarios |
| 10 | Interview preparation |
| 11 | Expert PostgreSQL and advanced SQL |
| 12 | Data engineering and analytics |
| 13 | Real-world projects |
| 14 | Production database operations: recovery, monitoring, incidents, capacity and RCA |
| 15 | PostgreSQL internals: catalogs, WAL, vacuum and planner statistics |
| 16 | Replication, high availability and disaster recovery |
| 17 | Backup, restore and PITR recovery labs |
| 18 | Safe schema migrations and zero/minimal-downtime patterns |
| 19 | Advanced PostgreSQL data types and identity/sequences |
| 20 | SQL/JSON, JSON path and JSON_TABLE |
| 21 | PostgreSQL administration, roles, configuration and FDW |
| 22 | Observability, locks, waits and query statistics |
| 23 | Database testing and CI/CD |
| 24 | PostgreSQL 18 features and upgrade readiness |
| 25 | Production capstone projects |
| 26 | Advanced PostgreSQL: event triggers, logical decoding, advanced indexes and server programming |
| 27 | Data governance, PII, retention, auditability and data quality |
| 28 | Capacity planning, scaling and cost engineering |
| 29 | Application/database integration patterns |
| 30 | Scenario-based production mastery |
| 31 | SQL standard and cross-database compatibility |
| 32 | Security hardening |
| 33 | Major-version migration and upgrade labs |
| 34 | Final SQL/PostgreSQL mastery checklist |
| 35 | PostgreSQL complete reference: information schema, JIT, parallelism, sampling, errors, limits and extensions |
| 36 | Database reliability engineering and SLOs |
| 37 | Streaming, CDC and event-driven data patterns |
| 38 | Search, text, fuzzy matching and multilingual considerations |
| 39 | Advanced data modeling and temporal/multi-tenant patterns |
| 40 | Final production simulation and recovery exercise |
| 41 | Runnable PostgreSQL labs: locks, queues, notifications, materialized views, COPY, time zones, partitions, RLS and query statistics |
| 42 | Production patterns: pooling, schema drift, performance regression and backup verification |
| 43 | Validation and automation: lab contracts, safety checks, version matrix and manifests |
| 44 | Advanced production SQL patterns |
| 45 | PostgreSQL CI integration with Docker, fixtures and assertions |
| 46 | Database client integration |
| 47 | Advanced concurrency and isolation |
| 48 | Data loading and export |
| 49 | Recovery and migration drills |
| 50 | Logical replication lab |
| 51 | SQL quality, linting and style |
| 52 | Observability and performance lab |
| 53 | Completeness audit and acceptance criteria |
| 54 | Multi-session and cluster labs |
| 55 | Production failure and chaos labs |
| 56 | Physical replication and major-upgrade labs |
| 57 | Runnable Python, Java JDBC and Node.js client integration labs |
| 58 | PostgreSQL 18 operational tools and upgrade-readiness checks |
| 59 | SQL error diagnostics, SQLSTATE and PL/pgSQL exception handling |
| 60 | Optional PostGIS and geospatial SQL |
| 61 | PostgreSQL testing, regression/isolation testing and server programming |

## 🛠️ Installation — Start Here

New to SQL? Follow the complete setup guide first.

**[📥 Installation Guide](INSTALLATION.md)** · **[⬇️ Download & Setup](DOWNLOAD-AND-SETUP.md)**

The setup documentation covers Windows, macOS and Linux, PostgreSQL, pgAdmin, `psql`, Git/ZIP download, database creation, verification, Docker, PATH/password/port troubleshooting and safe learning-database practices.

### Quick start

```text
Install PostgreSQL
      ↓
Verify psql
      ↓
Create sql_learning
      ↓
Clone/download this repository
      ↓
Run 00-installation
      ↓
Read the theory
      ↓
Start 01-beginner
      ↓
Practice → Projects → Production → Interviews
```

## 📚 Theory library

### Complete SQL Theory
**[COMPLETE-SQL-THEORY.md](COMPLETE-SQL-THEORY.md)**

A broad reference covering relational foundations, PostgreSQL behavior, data types, keys, constraints, normalization, logical query processing, NULL, joins, subqueries, aggregation, windows, CTEs, DDL/DML/DCL/TCL, transactions, MVCC, locks, execution plans, indexes, storage, WAL, security, JSONB, partitioning, OLTP/OLAP, ETL/ELT, CDC, replication, backups, distributed patterns, observability and production engineering.

### Core Concepts
**[CORE-CONCEPTS.md](CORE-CONCEPTS.md)** — a dictionary-style reference for important SQL and database terminology.

### Advanced & Expert Theory
**[ADVANCED-EXPERT-THEORY.md](ADVANCED-EXPERT-THEORY.md)** — deeper PostgreSQL internals, optimization, concurrency, distributed systems and production engineering.

### Curriculum Audit
**[MISSING-CONCEPTS-CHECKLIST.md](MISSING-CONCEPTS-CHECKLIST.md)** — a living checklist used to identify gaps as the curriculum evolves.

## 📖 SQL 101 compatibility layer

If you are coming from a beginner SQL guide, use **[SQL-101-COMPATIBILITY-GUIDE.md](SQL-101-COMPATIBILITY-GUIDE.md)** and the **[SQL-101-CURRICULUM-MATRIX.md](SQL-101-CURRICULUM-MATRIX.md)**.

It maps the familiar SQL 101 topics — installation, querying, modification, data types, constraints, joins, aggregation, subqueries, views, indexing, transactions, advanced SQL, best practices and exercises — to the deeper lessons in this repository.

For quick revision, use **[SQL-CHEAT-SHEET.md](SQL-CHEAT-SHEET.md)**.

For beginner-friendly rules and safe SQL habits, use **[SQL-101-BEST-PRACTICES.md](SQL-101-BEST-PRACTICES.md)**.

For a standalone 45-exercise progression, use **[SQL-101-PRACTICE-TRACK.md](SQL-101-PRACTICE-TRACK.md)**.

## 🧪 Exercises and practice

Practice is part of the curriculum, not an afterthought.

**[EXERCISES-AND-SOLUTIONS.md](EXERCISES-AND-SOLUTIONS.md)** provides original practice questions organized by difficulty, including:

- SELECT/filtering/sorting
- INSERT/UPDATE/DELETE
- constraints and data integrity
- JOINs
- aggregation
- subqueries and EXISTS
- CASE and NULL
- CTEs and recursive queries
- window functions
- transactions and concurrency
- indexes and EXPLAIN
- JSONB
- production troubleshooting
- interview-style scenarios
- regression, isolation and server-programming interview scenarios

Try each problem before reading the solution.

## 🧠 How to learn every concept

For every topic:

1. Definition — what is it?
2. Purpose — why does it exist?
3. Problem — what does it solve?
4. Mental model — how should you think about it?
5. Syntax — what does it look like?
6. Example — see it in action.
7. Explanation — understand each part.
8. Expected result — predict the output.
9. Practice — solve a similar problem.
10. Edge cases — understand unusual behavior.
11. Common mistakes — learn what can go wrong.
12. Performance — understand scale implications.
13. Security — understand safe usage.
14. Concurrency — understand simultaneous execution.
15. Production use — connect theory to real systems.
16. Interview questions — explain the concept clearly.

## 🏗️ Repository structure

```text
00-installation/
01-beginner/
02-intermediate/
03-advanced/
04-database-design/
05-transactions/
06-performance/
07-security/
08-banking-project/
09-real-world-scenarios/
10-interview-preparation/
11-expert-sql/
12-data-engineering/
13-real-world-projects/
14-production-operations/
15-postgresql-internals/
16-replication-and-ha/17-backup-and-recovery-labs/
18-schema-migrations/
19-advanced-types/
20-sql-json/
21-postgresql-administration/
22-observability/
23-testing-and-cicd/
24-postgresql-18/
25-capstone-projects/
26-advanced-postgresql/
27-data-governance/
28-capacity-and-cost/
29-client-integration/
30-interview-and-scenario-labs/
31-sql-standard-and-compatibility/
32-security-hardening/
33-migration-and-upgrade-labs/
34-final-master-checklist/
35-postgresql-complete-reference/
36-reliability-engineering/
37-streaming-and-event-data/
38-search-and-text/
39-advanced-data-modeling/
41-runnable-labs/
42-production-patterns/
43-validation-and-automation/
44-advanced-production-sql/
45-ci-postgresql/
46-database-client-integration/
47-advanced-concurrency/
48-data-loading-and-export/
49-recovery-and-migration-drills/
50-logical-replication-lab/
51-sql-quality-and-linting/
52-observability-and-performance-lab/
53-completeness-audit/
54-multi-session-and-cluster-labs/
55-production-failure-and-chaos-labs/
56-physical-replication-and-upgrade-lab/
57-client-integration-runnable-labs/
58-postgresql-18-operational-tools/
59-sql-error-diagnostics/
60-postgis-geospatial/
61-postgresql-testing-and-server-programming/
datasets/
docker/
web/

CORE-CONCEPTS.md
SQL-THEORY.md
COMPLETE-SQL-THEORY.md
ADVANCED-EXPERT-THEORY.md
SQL-CHEAT-SHEET.md
SQL-101-COMPATIBILITY-GUIDE.md
EXERCISES-AND-SOLUTIONS.md
MISSING-CONCEPTS-CHECKLIST.md
61-postgresql-testing-and-server-programming/README.md
ROADMAP.md
CONTRIBUTING.md
```

## 🏦 Real-world project

The banking project demonstrates how SQL concepts come together in a realistic domain:

- customers and accounts
- balances and transactions
- transfers
- reporting
- constraints and integrity
- seed data
- production-style query patterns

## 🖥️ SQL Learning Hub

The `web/` folder contains an optional local-first learning interface. It is designed to make the curriculum easier to navigate without requiring paid services or an external authentication provider for the learner demo.

## 🎯 Repository philosophy

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

The goal is not just to memorize SQL syntax. The goal is to understand **why a query works, what the database does with it, how it behaves under load, and how to use it safely in production**.

## 📚 Additional resources

See **[LEARNING-RESOURCES.md](LEARNING-RESOURCES.md)** for official PostgreSQL documentation, practice platforms, books, and a suggested study sequence.

## 🤝 Contributing

See **[CONTRIBUTING.md](CONTRIBUTING.md)** for contribution guidelines.

## 📄 License

This project is released under the license included in the repository.

---

**Goal:** understand SQL deeply enough to **explain it, write it, troubleshoot it, optimize it and use it safely in production.**