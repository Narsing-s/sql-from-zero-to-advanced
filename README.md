# SQL From Zero to Advanced 🚀

Welcome to a **theory-first, practical SQL learning journey**.

This repository is designed for someone who may be completely new to SQL. **Do not read the queries as magic syntax.** Learn the database concepts first, then use the SQL examples to prove the concept by running it.

## Start here

👉 **[Read the complete SQL Theory Guide](SQL-THEORY.md)**

The theory guide explains SQL from first principles through production engineering:

- What databases, tables, rows, columns and relationships mean
- SQL command families: DDL, DML, DQL, DCL and transactions
- How SELECT logically works
- Filtering and three-valued logic
- NULL
- JOINs
- GROUP BY and aggregation
- Keys and constraints
- Normalization
- Subqueries and CTEs
- Recursive queries
- Window functions
- CASE expressions
- Views and materialized views
- Functions, procedures and triggers
- Transactions, ACID, locks and isolation
- Indexes, composite indexes and query plans
- EXPLAIN / EXPLAIN ANALYZE
- Partitioning
- JSON/JSONB
- UPSERT and MERGE
- Data quality and idempotency
- Security and Row-Level Security
- Full-text search and LATERAL
- OLTP vs OLAP
- Connection pooling
- WAL, backups, recovery and replication
- Production troubleshooting and SQL anti-patterns

## How every lesson works

For each concept, follow this order:

1. **Theory** — understand the concept in plain English.
2. **What problem does it solve?**
3. **Mental model** — understand how to think about it.
4. **Syntax** — learn the general pattern.
5. **Example query** — see a small runnable example.
6. **Line-by-line explanation** — understand every important part.
7. **Expected result** — know what should happen.
8. **Practice** — solve a similar problem.
9. **Challenge** — solve a realistic problem.
10. **Real-world use** — connect the concept to production.
11. **Common mistakes** — learn what can go wrong.
12. **Interview questions** — verify understanding.

## Learning path

| Stage | What you learn |
|---|---|
| 00 | Install PostgreSQL and understand the environment |
| 01 | SQL foundations and CRUD |
| 02 | Joins, aggregation, subqueries and business logic |
| 03 | CTEs, recursion, windows, views, functions and triggers |
| 04 | Database design, keys, constraints and normalization |
| 05 | Transactions, ACID, locks and isolation |
| 06 | Indexes, execution plans and performance |
| 07 | Roles, permissions and database security |
| 08 | Complete banking database |
| 09 | Production troubleshooting scenarios |
| 10 | Interview preparation |
| 11 | Expert PostgreSQL |
| 12 | Data engineering and analytics |
| 13 | Real-world projects |

## SQL is not just queries

The goal is to understand **why** a query works.

Before writing SQL, ask:

- What data do I need?
- Where does that data live?
- How are the tables related?
- Which rows should be included?
- Can NULL affect the answer?
- Can a JOIN multiply rows?
- Should the result be grouped?
- Is a window calculation required?
- What business rule am I implementing?
- What constraints protect the data?
- Will the query perform well with millions of rows?
- What happens if two users execute it at the same time?
- What permissions should the operation have?
- How will the system recover if something fails?

## Hands-on learning

The SQL files are the **practice layer**.

The README files and **[SQL-THEORY.md](SQL-THEORY.md)** are the **understanding layer**.

Use both together:

```text
THEORY
  ↓
MENTAL MODEL
  ↓
EXAMPLE
  ↓
RUN SQL
  ↓
OBSERVE RESULT
  ↓
PRACTICE
  ↓
REAL-WORLD SCENARIO
  ↓
PRODUCTION THINKING
```

## UI

The `web/` folder contains a local-first learning interface. It requires **no API keys, no paid services, and no external authentication provider** for the learner demo.

## Start

1. Read **[SQL-THEORY.md](SQL-THEORY.md)**.
2. Begin with **[00-installation](00-installation/README.md)**.
3. Progress through the numbered folders.
4. Run the SQL examples.
5. Complete the exercises.
6. Build the real-world projects.
7. Use the interview and production-scenario sections to test yourself.
