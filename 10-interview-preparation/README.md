# 10 — SQL Interview Preparation

## Goal
Turn understanding into clear technical explanations and scenario-based problem solving.

## Beginner
- database, DBMS and RDBMS
- keys and constraints
- NULL
- WHERE vs HAVING
- DELETE vs TRUNCATE
- normalization

## Intermediate
- JOINs
- GROUP BY
- subqueries
- EXISTS
- duplicate detection
- second-highest salary
- aggregation
- window functions

## Advanced
- CTEs and recursive CTEs
- execution plans
- indexes
- ACID and MVCC
- isolation
- locks
- deadlocks
- transactions

## Scenario format
Symptom → Investigation → Evidence → Root Cause → Fix → Prevention

## Strong answer format
Definition → Why → Example → Edge case → Production consideration

Do not memorize only the final query. Explain why it works.


## Complete theory Q&A

- [Complete SQL Theory — Questions & Answers](./complete-theory-qa.md) — 85 interview-ready theory questions covering SQL foundations, queries, analytics, NULL/type semantics, transactions, MVCC, indexes, planner behavior, WAL, replication, security, data engineering, PostgreSQL 18 and production operations.
- [Production Scenario Questions & Answers](./production-scenarios-qa.md) — 60 production troubleshooting and design scenarios covering performance, locks, correctness, availability, backup/PITR, replication, security, migrations, ETL, capacity and incident response.

Use the Q&A after studying the underlying theory. The answers are deliberately structured as definition/reasoning/evidence/trade-off guidance rather than memorization-only one-liners.


## Stage 61 — Testing & Server Programming

- [Regression & isolation testing](../61-postgresql-testing-and-server-programming/01-regression-and-isolation-testing.md)
- [Server programming theory](../61-postgresql-testing-and-server-programming/02-server-programming-theory.md)
- [Testing & server programming scenario Q&A](../61-postgresql-testing-and-server-programming/03-testing-and-server-programming-scenarios-qa.md) — 50 model-answer scenarios.


## Stage 62 — Advanced Internals & Interfaces

- [Advanced theory Q&A](../62-postgresql-advanced-internals-and-interfaces/01-advanced-theory-qa.md) — 50 advanced PostgreSQL internals/interface questions.
- [Advanced scenario Q&A](../62-postgresql-advanced-internals-and-interfaces/02-advanced-scenarios-qa.md) — 40 production troubleshooting scenarios.


## Stage 63 — Internals, Extensibility & Failure Semantics

- [Advanced internals/extensibility theory Q&A](../63-postgresql-internals-extensibility/01-internals-extensibility-theory-qa.md) — 50 questions covering query rewrite, execution internals, MVCC/storage, WAL, extensibility, procedural handlers, SPI, FDW, logical replication failover and MERGE.
- [Advanced internals/extensibility scenario Q&A](../63-postgresql-internals-extensibility/02-internals-extensibility-scenarios-qa.md) — 40 production troubleshooting scenarios with model answers.
