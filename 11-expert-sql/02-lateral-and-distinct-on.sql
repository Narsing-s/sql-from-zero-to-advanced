-- ============================================================
-- 02 — LATERAL and DISTINCT ON
-- ============================================================
--
-- Definition:
-- LATERAL allows a subquery in FROM to reference columns from rows
-- produced earlier in that FROM clause. DISTINCT ON is PostgreSQL
-- syntax for keeping the first row in each distinct group.
--
-- Purpose:
-- Learn two powerful PostgreSQL techniques for "latest row per group"
-- and other top-per-group problems.
--
-- Mental model:
-- LATERAL: outer row -> dependent subquery -> best matching row
-- DISTINCT ON: group -> ORDER BY priority -> first row kept
--
-- Expected result:
-- Both examples target the latest transaction for each account.
--
-- Important:
-- For DISTINCT ON, the ORDER BY should begin with the DISTINCT ON
-- expressions and then define which row wins.
--
-- Performance:
-- Top-per-group queries should be checked with EXPLAIN on realistic
-- data. Indexes that match filtering/grouping/order patterns can help.
--
-- Production use:
-- Latest status, latest payment, most recent event, and top-per-group
-- reporting are common applications.
--
-- Interview:
-- When would you choose LATERAL instead of DISTINCT ON?
-- ============================================================

SELECT a.account_id, t.transaction_id, t.amount
FROM bank.accounts a
LEFT JOIN LATERAL (
  SELECT transaction_id, amount
  FROM bank.transactions t
  WHERE t.account_id = a.account_id
  ORDER BY t.transaction_date DESC
  LIMIT 1
) t ON true;

SELECT DISTINCT ON (account_id)
       account_id, transaction_id, amount, transaction_date
FROM bank.transactions
ORDER BY account_id, transaction_date DESC;
