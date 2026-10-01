-- FILTER keeps conditional aggregation readable.
SELECT
  account_id,
  COUNT(*) AS total_transactions,
  COUNT(*) FILTER (WHERE transaction_type = 'DEPOSIT') AS deposits,
  COUNT(*) FILTER (WHERE transaction_type = 'WITHDRAWAL') AS withdrawals
FROM bank.transactions
GROUP BY account_id;

-- Ordered aggregation.
SELECT account_id,
       string_agg(transaction_type, ', ' ORDER BY transaction_date DESC) AS recent_activity
FROM bank.transactions
GROUP BY account_id;
