# 00 — Installation & Environment

## Goal
Set up PostgreSQL and understand the database environment before writing SQL.

## Learn
- PostgreSQL server, database, schema and session
- psql and pgAdmin
- connections and execution
- running SQL scripts safely
- environment verification

## Mental model
PostgreSQL server → database → schema → table → rows

A connection creates a session. SQL commands run inside that session against database objects.

## Windows setup

Install PostgreSQL and optionally pgAdmin.

Verify:
    psql --version

Connect:
    psql -U postgres

Create the training database:
    CREATE DATABASE sql_learning;

Connect to it and run postgresql-setup.sql, then verification.sql.

## Common mistakes
- Wrong database or port
- Setup scripts run out of order
- Confusing database and schema
- Running destructive SQL against the wrong database

## Practice
Create a second database and explain the difference between server, database, schema and table.

## Next
Continue to 01 — Beginner SQL.
