-- LATERAL lets a subquery use columns from the row before it.
-- PostgreSQL example: latest transaction per account.
SELECT a.account_id, t.transaction_id, t.amount
FROM bank.accounts a
LEFT JOIN LATERAL (
  SELECT transaction_id, amount
  FROM bank.transactions t
  WHERE t.account_id = a.account_id
  ORDER BY t.transaction_date DESC
  LIMIT 1
) t ON true;

-- DISTINCT ON is a PostgreSQL-specific shortcut for "first row per group".
SELECT DISTINCT ON (account_id)
       account_id, transaction_id, amount, transaction_date
FROM bank.transactions
ORDER BY account_id, transaction_date DESC;
