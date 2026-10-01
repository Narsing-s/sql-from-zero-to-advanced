# 03 — Advanced SQL

Advanced SQL expresses multi-step logic clearly.

## CTEs
A Common Table Expression gives a temporary name to a query result.
```sql
WITH customer_totals AS (
  SELECT customer_id, SUM(amount) AS total_amount
  FROM bank.transactions GROUP BY customer_id
)
SELECT * FROM customer_totals WHERE total_amount > 100000;
```
Think of a CTE as a named intermediate result.

## Recursive CTEs
A recursive CTE repeatedly uses previous results. It is useful for employee hierarchies, category trees and dependency chains. Always define a stopping condition.

## Window functions
GROUP BY reduces rows. Window functions calculate across related rows while keeping the original rows.
```sql
SELECT account_id, transaction_date, amount,
       SUM(amount) OVER (PARTITION BY account_id ORDER BY transaction_date) AS running_total
FROM bank.transactions;
```
Read it as: “For each account, walk through transactions in date order and keep a running sum.”

## Views
A view stores a reusable query definition. It is useful when many consumers need the same logical result.

## Functions, procedures and triggers
Functions encapsulate reusable logic. Procedures perform database operations. Triggers automatically react to database events; use them carefully because they can hide side effects.

## Query thinking
For every advanced query identify: input tables → relationships → filters → transformations → aggregation → ordering → output.
