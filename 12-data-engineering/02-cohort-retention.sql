-- Cohort analysis: first activity month versus later activity.
WITH first_activity AS (
  SELECT account_id, date_trunc('month', MIN(transaction_date)) AS cohort_month
  FROM bank.transactions
  GROUP BY account_id
),
activity AS (
  SELECT DISTINCT account_id, date_trunc('month', transaction_date) AS activity_month
  FROM bank.transactions
)
SELECT
  f.cohort_month,
  a.activity_month,
  COUNT(DISTINCT a.account_id) AS active_accounts
FROM first_activity f
JOIN activity a USING (account_id)
GROUP BY f.cohort_month, a.activity_month
ORDER BY f.cohort_month, a.activity_month;
