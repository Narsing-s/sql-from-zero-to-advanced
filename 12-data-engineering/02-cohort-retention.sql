-- ============================================================
-- 02 — Cohort analysis and retention
-- ============================================================
--
-- Definition:
-- Cohort analysis groups entities by a shared starting period and
-- measures their later activity.
--
-- Purpose:
-- Demonstrate how an account's first transaction month can become its
-- cohort and later transaction months can be compared with that cohort.
--
-- Mental model:
-- First activity -> cohort month
-- Later activity -> activity month
-- Cohort + activity -> active population
--
-- Expected result:
-- Each cohort/activity-month pair reports the number of distinct active
-- accounts.
--
-- Note:
-- This banking schema uses created_at rather than transaction_date, so
-- this lesson uses created_at for the transaction event timestamp.
--
-- Practice:
-- Calculate a month offset such as activity month minus cohort month.
--
-- Performance:
-- Cohort queries can scan large event tables. Consider pre-aggregated
-- analytics tables or appropriate indexes for production workloads.
--
-- Production use:
-- Customer retention, product adoption, subscription activity, and
-- operational lifecycle analysis.
--
-- Interview:
-- What is the difference between a cohort and an activity period?
-- ============================================================

WITH first_activity AS (
  SELECT account_id,
         date_trunc('month', MIN(created_at)) AS cohort_month
  FROM bank.transactions
  GROUP BY account_id
),
activity AS (
  SELECT DISTINCT account_id,
         date_trunc('month', created_at) AS activity_month
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
