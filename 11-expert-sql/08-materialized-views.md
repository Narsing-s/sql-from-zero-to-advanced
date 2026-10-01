# Materialized Views

A normal view stores a query definition. A materialized view stores the query result until refreshed.

Use a materialized view when:
- the underlying query is expensive,
- data can tolerate refresh lag,
- many users repeatedly need the same aggregate.

Example:

```sql
CREATE MATERIALIZED VIEW bank.daily_transaction_summary AS
SELECT date_trunc('day', transaction_date) AS day,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM bank.transactions
GROUP BY 1;

REFRESH MATERIALIZED VIEW bank.daily_transaction_summary;
```

Trade-off: faster reads versus refresh cost and potentially stale data.
