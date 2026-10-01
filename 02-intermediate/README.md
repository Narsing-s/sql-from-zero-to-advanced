# 02 — Intermediate SQL

## Goal
Learn how to combine tables and turn raw rows into useful business information.

## JOINs
A JOIN connects rows from different tables using a relationship.
```sql
SELECT c.name, a.account_number, a.balance
FROM bank.customers c
JOIN bank.accounts a ON a.customer_id = c.customer_id;
```
Read ON as: “Connect an account to the customer whose ID is the same.”

INNER JOIN returns matching rows. LEFT JOIN keeps every row from the left table even without a match.

## GROUP BY
GROUP BY creates groups before calculating an aggregate.
```sql
SELECT customer_id, COUNT(*) AS account_count
FROM bank.accounts
GROUP BY customer_id;
```
Think: put related accounts into buckets, then count each bucket.

## HAVING
WHERE filters rows before grouping. HAVING filters groups after grouping.
```sql
SELECT customer_id, COUNT(*) AS account_count
FROM bank.accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

## Subqueries
A subquery is a query inside another query. Its result becomes input to the outer query.

## CASE
CASE implements conditional business rules.
```sql
SELECT account_number, balance,
       CASE WHEN balance < 0 THEN 'OVERDRAWN'
            WHEN balance = 0 THEN 'ZERO'
            ELSE 'POSITIVE' END AS balance_status
FROM bank.accounts;
```

## Practice
Write the English requirement first, then SQL. Example: “Show each customer and their number of transactions.”
