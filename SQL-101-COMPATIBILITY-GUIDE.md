# SQL 101 Compatibility Guide

This guide makes the repository easy to follow for learners coming from a traditional SQL 101 curriculum.

## Topic mapping

| SQL 101 topic | Where to learn it here |
|---|---|
| Installation | `INSTALLATION.md`, `DOWNLOAD-AND-SETUP.md`, `00-installation/` |
| Database basics | `01-beginner/`, `CORE-CONCEPTS.md` |
| SELECT and filtering | `01-beginner/` |
| INSERT, UPDATE, DELETE | `01-beginner/` |
| Data types | `01-beginner/`, `COMPLETE-SQL-THEORY.md` |
| Primary/foreign/unique/check constraints | `01-beginner/`, `04-database-design/` |
| Relationships | `04-database-design/`, `02-intermediate/` |
| JOINs | `02-intermediate/` |
| Aggregation and GROUP BY | `02-intermediate/` |
| Subqueries | `02-intermediate/` |
| Views | `03-advanced/` |
| Indexing | `06-performance/` |
| Transactions and ACID | `05-transactions/` |
| Isolation and concurrency | `05-transactions/` |
| Stored functions/procedures | `03-advanced/` |
| Triggers | `03-advanced/` |
| Best practices | `01-beginner/11-sql-best-practices.sql` |
| Advanced SQL | `03-advanced/`, `11-expert-sql/` |
| Exercises | `EXERCISES-AND-SOLUTIONS.md` and lesson exercise folders |
| Real-world SQL | `08-banking-project/`, `09-real-world-scenarios/`, `13-real-world-projects/` |
| Interview preparation | `10-interview-preparation/` |

## Recommended beginner sequence

1. Read the installation guide.
2. Create the `sql_learning` database.
3. Complete `01-beginner`.
4. Use the cheat sheet for revision.
5. Complete the practice questions without looking at solutions.
6. Continue through JOINs and aggregation.
7. Learn transactions and indexes before moving into expert PostgreSQL.

## Why this repository goes further

A beginner SQL course normally focuses on writing queries. This repository adds the surrounding engineering skills needed for real systems: execution plans, PostgreSQL internals, concurrency, security, observability, recovery, data engineering and production troubleshooting.

## Important note

This is an original learning guide. It uses common SQL concepts and terminology, but does not copy proprietary or copyrighted course material.
