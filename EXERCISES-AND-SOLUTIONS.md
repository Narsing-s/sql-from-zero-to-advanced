# SQL Exercises and Solutions 🧪

Use these exercises after studying the corresponding lessons. Try each problem first; then compare your solution with the reference answer.

## Beginner

### 1. Filter customers
**Task:** Return customers whose status is `ACTIVE`, ordered by name.

**Solution**
```sql
SELECT customer_id, name, status
FROM customers
WHERE status = 'ACTIVE'
ORDER BY name;
```

### 2. Find high balances
**Task:** Return accounts with a balance greater than 10,000.

**Solution**
```sql
SELECT account_id, account_number, balance
FROM accounts
WHERE balance > 10000
ORDER BY balance DESC;
```

### 3. Safe update
**Task:** Increase the balance of account 10 by 500.

**Solution**
```sql
UPDATE accounts
SET balance = balance + 500
WHERE account_id = 10;
```

## Intermediate

### 4. Customer account count
**Task:** Show every customer and the number of accounts they own, including customers with zero accounts.

**Solution**
```sql
SELECT c.customer_id,
       c.name,
       COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a
  ON a.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;
```

### 5. Customers above an aggregate threshold
**Task:** Return customers whose total account balance is above 50,000.

**Solution**
```sql
SELECT c.customer_id,
       c.name,
       SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a
  ON a.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(a.balance) > 50000;
```

### 6. Customers with transactions
**Task:** Return customers who have at least one transaction.

**Solution**
```sql
SELECT c.customer_id, c.name
FROM customers c
WHERE EXISTS (
  SELECT 1
  FROM accounts a
  JOIN transactions t
    ON t.account_id = a.account_id
  WHERE a.customer_id = c.customer_id
);
```

## Advanced

### 7. Latest transaction per account
**Task:** Return the latest transaction for each account.

**Solution**
```sql
WITH ranked AS (
  SELECT t.*,
         ROW_NUMBER() OVER (
           PARTITION BY account_id
           ORDER BY transaction_date DESC, transaction_id DESC
         ) AS rn
  FROM transactions t
)
SELECT *
FROM ranked
WHERE rn = 1;
```

### 8. Running transaction total
**Task:** Calculate a running total for each account.

**Solution**
```sql
SELECT account_id,
       transaction_date,
       amount,
       SUM(amount) OVER (
         PARTITION BY account_id
         ORDER BY transaction_date, transaction_id
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM transactions;
```

### 9. Duplicate emails
**Task:** Find email addresses that occur more than once.

**Solution**
```sql
SELECT email, COUNT(*) AS occurrences
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;
```

### 10. Query investigation
**Task:** Investigate a slow customer lookup and identify whether the planner uses an appropriate index.

**Solution pattern**
```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM customers
WHERE email = 'user@example.com';
```

Then check the execution plan, estimated versus actual rows, scan type, buffer activity and whether the predicate is sargable.

## Production scenarios

### 11. Deadlock investigation
Two transactions lock resources in different orders.

**What to investigate:**
- database logs
- blocked and blocking sessions
- transaction order
- lock types
- transaction duration
- application retry behavior

### 12. Duplicate data after retry
An integration retries a request after a timeout and creates the same business record twice.

**Possible database controls:**
- unique business key
- idempotency key
- `INSERT ... ON CONFLICT`
- transaction boundaries
- application-level retry policy

### 13. Sudden query slowdown
A query that normally completes quickly becomes slow.

**Investigation sequence:**
1. Capture `EXPLAIN (ANALYZE, BUFFERS)`.
2. Compare estimated and actual row counts.
3. Check statistics and `ANALYZE`.
4. Check index usage.
5. Check locks/blocking.
6. Check recent schema/data changes.
7. Check resource pressure.

## Practice rule

Do not memorize the answers. Change the table names, conditions and requirements and solve the problem again.

For more scenarios, continue to `09-real-world-scenarios/` and `10-interview-preparation/`.
