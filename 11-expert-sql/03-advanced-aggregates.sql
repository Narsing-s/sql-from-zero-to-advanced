-- ============================================================
-- 03 — Advanced aggregates
-- ============================================================
--
-- Definition:
-- Aggregate functions summarize multiple rows. PostgreSQL extends
-- ordinary aggregation with features such as FILTER and ordered
-- aggregation.
--
-- Purpose:
-- Write readable conditional summaries and ordered activity lists.
--
-- Mental model:
-- rows -> group -> optional condition/order -> aggregate result
--
-- Expected result:
-- The first query counts all transactions and selected transaction
-- types per account. The second creates an ordered activity string.
--
-- Key concept:
-- FILTER applies a condition to one aggregate without forcing separate
-- queries or hard-to-read CASE expressions.
--
-- Common mistake:
-- string_agg output is presentation-oriented; do not use it as a
-- substitute for normalized relational data.
--
-- Performance:
-- Aggregation and ordered aggregates can require memory/sorting.
-- Measure with EXPLAIN ANALYZE on representative data.
--
-- Production use:
-- KPI reports, activity summaries, exports, and operational dashboards.
--
-- Interview:
-- How does FILTER differ from putting a condition in WHERE?
-- ============================================================

SELECT
  account_id,
  COUNT(*) AS total_transactions,
  COUNT(*) FILTER (WHERE transaction_type = 'DEPOSIT') AS deposits,
  COUNT(*) FILTER (WHERE transaction_type = 'WITHDRAWAL') AS withdrawals
FROM bank.transactions
GROUP BY account_id;

SELECT account_id,
       string_agg(transaction_type, ', ' ORDER BY transaction_date DESC) AS recent_activity
FROM bank.transactions
GROUP BY account_id;
