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


## Stage 64 — PostgreSQL 18 Modern Features
- [Modern features theory Q&A](../64-postgresql-18-modern-features/01-modern-features-theory-qa.md) — 35 version-specific theory questions.
- [Modern features scenario Q&A](../64-postgresql-18-modern-features/02-modern-features-scenarios-qa.md) — 30 production scenarios.


## Stage 65 — PostgreSQL Deep Internals
- [Deep internals theory Q&A](../65-postgresql-deep-internals/01-deep-internals-theory-qa.md) — 50 questions.
- [Deep internals scenario Q&A](../65-postgresql-deep-internals/02-deep-internals-scenarios-qa.md) — 30 production scenarios.


## Stage 66 — Logical Replication & CDC Deep Dive
- [Logical replication theory Q&A](../66-logical-replication-and-cdc-deep-dive/01-logical-replication-theory-qa.md) — 50 questions.
- [Logical replication scenario Q&A](../66-logical-replication-and-cdc-deep-dive/02-logical-replication-scenarios-qa.md) — 30 production scenarios.


## Stage 67 — PostgreSQL Server Tools & Deep Observability
- [Server tools theory Q&A](../67-postgresql-server-tools-and-deep-observability/01-server-tools-theory-qa.md) — 50 questions.
- [Server tools scenario Q&A](../67-postgresql-server-tools-and-deep-observability/02-server-tools-scenarios-qa.md) — 30 production scenarios.


## Stage 68 — PostgreSQL Client Interfaces & SQL Conformance
- [Client interfaces theory Q&A](../68-postgresql-client-interfaces-and-conformance/01-client-interfaces-theory-qa.md) — 50 questions.
- [Client interfaces scenario Q&A](../68-postgresql-client-interfaces-and-conformance/02-client-interfaces-scenarios-qa.md) — 30 production scenarios.


## Stage 69 — Reproducible SQL Engineering
- [Reproducible SQL engineering guide](../69-reproducible-sql-engineering/README.md) — fixtures, assertions, safe lab classification, concurrency reproducibility and benchmark metadata.


## Stage 70 — Production Integration & Verification

See [`70-production-integration-and-verification/README.md`](../70-production-integration-and-verification/README.md) for transaction boundaries, parameter binding, retryable failures, pooling, streaming, timeout hierarchy, CI database verification, recovery rehearsal and production acceptance.
