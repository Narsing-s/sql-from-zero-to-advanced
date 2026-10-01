# SQL 101 — Original Quick Notes

A compact beginner reference inspired by the *topic coverage* of SQL 101, written specifically for this repository.

## 1. Database basics

A relational database stores data in tables made of rows and columns.

Think in layers:

`server → database → schema → table → row → column`

A **primary key** identifies a row. A **foreign key** connects related tables.

## 2. Core SQL statements

### SELECT
Retrieves data.

```sql
SELECT customer_id, name
FROM customers
WHERE status = 'ACTIVE'
ORDER BY name;
```

### INSERT
Creates rows.

```sql
INSERT INTO customers (name, email)
VALUES ('Alex', 'alex@example.com');
```

### UPDATE
Changes existing rows.

```sql
UPDATE customers
SET status = 'ACTIVE'
WHERE customer_id = 10;
```

### DELETE
Removes rows.

```sql
DELETE FROM customers
WHERE customer_id = 10;
```

**Safety rule:** inspect the matching rows with SELECT before running UPDATE or DELETE.

## 3. Data types and constraints

Common types include integers, exact numerics, text, dates/timestamps and booleans.

Core constraints:

- PRIMARY KEY — row identity
- FOREIGN KEY — referential integrity
- UNIQUE — no duplicate value
- NOT NULL — value required
- CHECK — business rule
- DEFAULT — fallback value

Use exact numeric types such as `NUMERIC` for monetary values rather than relying on floating-point arithmetic.

## 4. Relationships and JOINs

Typical relationships:

- one-to-one
- one-to-many
- many-to-many

Many-to-many relationships normally use a junction table.

Common joins:

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL JOIN
- CROSS JOIN
- SELF JOIN

Always ask: **what is the row grain after this join?** A one-to-many join can multiply rows.

## 5. Aggregation

Use aggregate functions to summarize rows:

`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`

```sql
SELECT customer_id, COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

Remember:

- WHERE filters rows before grouping.
- HAVING filters groups after aggregation.

## 6. Subqueries and set operations

A subquery is a query nested inside another query.

Prefer `EXISTS` when the requirement is simply to test whether a related row exists.

Important set operators:

- UNION
- UNION ALL
- INTERSECT
- EXCEPT

`UNION` removes duplicates; `UNION ALL` preserves them and usually avoids the duplicate-removal work.

## 7. NULL

NULL means unknown/missing, not zero and not an empty string.

Use:

```sql
WHERE email IS NULL
WHERE email IS NOT NULL
```

Not:

```sql
WHERE email = NULL
```

SQL's three-valued logic means comparisons involving NULL can evaluate to UNKNOWN.

## 8. Views

A view is a stored query that can be queried like a relation.

Use views to expose stable query interfaces and hide repetitive query logic. A materialized view stores query results and requires refresh strategy.

## 9. Indexes and performance

Indexes can reduce lookup work, but they add storage and write-maintenance cost.

Start performance investigations with:

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM customers
WHERE email = 'alex@example.com';
```

Do not assume an index is useful just because it exists. Check the actual execution plan.

## 10. Transactions

A transaction groups related operations into one logical unit.

```sql
BEGIN;

-- related changes

COMMIT;
-- or ROLLBACK;
```

Know ACID:

- Atomicity
- Consistency
- Isolation
- Durability

Then learn isolation levels, locks, blocking, deadlocks and retry behavior.

## 11. Advanced SQL

After the beginner path, continue with:

- CTEs and recursive CTEs
- window functions
- functions and procedures
- triggers
- JSONB
- generated columns
- partitioning
- full-text search
- advanced indexes

## 12. Practice method

For each concept:

1. Read the explanation.
2. Run the example.
3. Predict the result before executing it.
4. Change the requirement.
5. Write the query yourself.
6. Test edge cases.
7. Explain the query in plain English.
8. Investigate performance where relevant.

## 13. Production mindset

A correct SQL query is only the beginning. For production systems also consider:

**correctness → concurrency → performance → security → observability → recovery**

Use the advanced modules in this repository to continue beyond beginner SQL.
