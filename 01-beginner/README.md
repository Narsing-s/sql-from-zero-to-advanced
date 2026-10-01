# 01 — Beginner SQL

## Goal
Build a correct mental model for tables, rows, columns and basic SQL.

## What is SQL?
SQL (Structured Query Language) is a declarative language for working with relational data. You describe what result you need; the database chooses how to execute it.

## Mental model
Database → Schema → Table → Row → Column → Value

- Table = related rows
- Row = one record
- Column = one attribute
- Primary key = row identity

## Core commands

SELECT reads data.

    SELECT customer_id, name
    FROM beginner.customers;

WHERE filters rows.

    SELECT customer_id, name
    FROM beginner.customers
    WHERE city = 'Hyderabad';

ORDER BY controls result order.

    SELECT name, created_at
    FROM beginner.customers
    ORDER BY created_at DESC;

INSERT creates a row.

    INSERT INTO beginner.customers(name, email)
    VALUES ('Anita', 'anita@example.com');

UPDATE changes matching rows.

    UPDATE beginner.customers
    SET email = 'new@example.com'
    WHERE customer_id = 1;

DELETE removes matching rows.

    DELETE FROM beginner.customers
    WHERE customer_id = 1;

## Safety rule
Always inspect the WHERE condition before UPDATE or DELETE.

For a practical checklist covering naming, formatting, safe modifications, transactions, NULL, parameterization, verification and production thinking, see:

**[SQL Best Practices](11-sql-best-practices.sql)**

## Learning method
Definition → Purpose → English sentence → SQL → Predict result → Run → Explain

## Practice
Complete the exercises without copying the answer first.

## Next
Continue to 02 — Intermediate SQL.
