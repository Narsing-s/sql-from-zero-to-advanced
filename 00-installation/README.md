# 00 — Installation & Environment

## Goal

Set up a SQL learning environment and understand the database tools before writing queries.

This repository is **PostgreSQL-first**, while the SQL concepts are intentionally transferable to MySQL, SQL Server and SQLite. PostgreSQL is used for the runnable labs because it provides a strong foundation for advanced SQL and production database topics.

## Choose your database

| Database | Role in this repository | Verification |
|---|---|---|
| PostgreSQL | **Primary / recommended** | `psql --version` |
| MySQL | SQL syntax comparison and optional practice | `mysql --version` |
| SQLite | Lightweight local experimentation | `sqlite3 --version` |
| SQL Server | Cross-database syntax awareness | `sqlcmd --version` |

Some advanced lessons use PostgreSQL-specific features such as JSONB, RLS, advisory locks, EXPLAIN behavior and PostgreSQL transaction semantics. Always follow the lesson's database requirement.

## PostgreSQL setup

Install PostgreSQL and optionally pgAdmin.

Verify:

```bash
psql --version
```

Connect:

```bash
psql -U postgres
```

Create the training database:

```sql
CREATE DATABASE sql_learning;
```

Connect to it and run:

```text
00-installation/postgresql-setup.sql
00-installation/verification.sql
```

## MySQL setup

Install MySQL Server and the MySQL command-line client.

Verify:

```bash
mysql --version
```

The beginner SQL concepts in `01-beginner/` can be adapted to MySQL, but PostgreSQL remains the canonical execution environment for this repository.

## SQLite setup

SQLite is useful when you want a lightweight SQL playground without running a database server.

Verify:

```bash
sqlite3 --version
```

SQLite syntax and feature support differ from PostgreSQL, so use it mainly for portable SQL fundamentals.

## Mental model

```text
Database server
      ↓
Database
      ↓
Schema
      ↓
Table
      ↓
Rows + Columns
```

A connection creates a session. SQL commands run inside that session against database objects.

## Download the repository

Using Git:

```bash
git clone https://github.com/Narsing-s/sql-from-zero-to-advanced.git
cd sql-from-zero-to-advanced
```

Or download the repository as a ZIP from GitHub.

## First learning sequence

```text
Install database
      ↓
Verify client
      ↓
Create sql_learning
      ↓
Run setup
      ↓
Run verification
      ↓
01-beginner
      ↓
02-intermediate
      ↓
03-advanced
```

## Common mistakes

- Wrong database, host or port
- Incorrect username/password
- Running scripts against the wrong database
- Running setup scripts out of order
- Confusing a database with a schema
- Assuming PostgreSQL syntax works identically in every RDBMS
- Running destructive SQL without checking the `WHERE` condition

## Safe learning practice

Use a dedicated learning database such as `sql_learning`. Never experiment with destructive statements against a production database.

Before an `UPDATE` or `DELETE`, run the equivalent `SELECT` first to verify the rows that will be affected.

## Next

Continue to **01 — Beginner SQL** and follow the SQL 101-compatible learning path in `SQL-101-COMPATIBILITY-GUIDE.md`.
