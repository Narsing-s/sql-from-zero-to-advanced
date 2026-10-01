# SQL Cheat Sheet 📌

A compact revision guide for the most common SQL concepts in this repository.

## SELECT

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1 ASC
LIMIT 10;
```

Common filters: `=`, `<>`, `>`, `>=`, `<`, `<=`, `BETWEEN`, `IN`, `LIKE`, `IS NULL`, `IS NOT NULL`.

## INSERT / UPDATE / DELETE

```sql
INSERT INTO customers (name, email)
VALUES ('Alex', 'alex@example.com');

UPDATE customers
SET email = 'new@example.com'
WHERE customer_id = 1;

DELETE FROM customers
WHERE customer_id = 1;
```

Always verify the `WHERE` condition before UPDATE or DELETE.

## JOINs

```sql
SELECT c.name, a.account_number
FROM customers c
INNER JOIN accounts a
  ON a.customer_id = c.customer_id;
```

Know: INNER, LEFT, RIGHT, FULL, CROSS and self joins.

## Aggregation

```sql
SELECT customer_id, COUNT(*) AS account_count, SUM(balance) AS total_balance
FROM accounts
GROUP BY customer_id
HAVING SUM(balance) > 10000;
```

Common functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`.

## CASE

```sql
SELECT account_number,
       CASE
         WHEN balance >= 100000 THEN 'HIGH'
         WHEN balance >= 10000 THEN 'MEDIUM'
         ELSE 'LOW'
       END AS balance_band
FROM accounts;
```

## Subqueries and EXISTS

```sql
SELECT c.*
FROM customers c
WHERE EXISTS (
  SELECT 1
  FROM accounts a
  WHERE a.customer_id = c.customer_id
);
```

## CTE

```sql
WITH customer_totals AS (
  SELECT customer_id, SUM(balance) AS total_balance
  FROM accounts
  GROUP BY customer_id
)
SELECT *
FROM customer_totals
WHERE total_balance > 10000;
```

## Window functions

```sql
SELECT customer_id,
       transaction_date,
       amount,
       SUM(amount) OVER (
         PARTITION BY customer_id
         ORDER BY transaction_date
       ) AS running_total
FROM transactions;
```

Common functions: `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, `SUM` and `AVG` over a window.

## Constraints

Typical integrity controls:

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- CHECK
- DEFAULT

## Transactions

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

COMMIT;
-- or ROLLBACK;
```

For production systems, understand ACID, isolation, locks, blocking and deadlocks.

## Indexes and EXPLAIN

```sql
CREATE INDEX idx_accounts_customer_id
ON accounts(customer_id);

EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM accounts
WHERE customer_id = 10;
```

Do not add indexes blindly. Measure query behavior and write/read trade-offs.

## PostgreSQL essentials

Useful PostgreSQL concepts include:

- `RETURNING`
- `ON CONFLICT`
- `MERGE`
- `JSONB`
- arrays
- generated columns
- partial/expression indexes
- materialized views
- row-level security
- full-text search
- partitioning
- `VACUUM` and `ANALYZE`

For details, use the numbered lessons and theory library.
