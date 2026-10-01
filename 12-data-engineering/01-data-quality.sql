-- Null-rate check
SELECT
  COUNT(*) AS total_rows,
  COUNT(*) FILTER (WHERE email IS NULL) AS missing_email,
  ROUND(100.0 * COUNT(*) FILTER (WHERE email IS NULL) / NULLIF(COUNT(*),0), 2) AS missing_email_pct
FROM beginner.customers;

-- Duplicate business keys
SELECT email, COUNT(*)
FROM beginner.customers
GROUP BY email
HAVING COUNT(*) > 1;

-- Referential integrity check
SELECT a.account_id
FROM bank.accounts a
LEFT JOIN bank.customers c ON c.customer_id = a.customer_id
WHERE c.customer_id IS NULL;
