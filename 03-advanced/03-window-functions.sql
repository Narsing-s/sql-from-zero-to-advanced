-- ============================================================
-- 03 — Window functions: analytics without collapsing rows
-- ============================================================
--
-- Definition:
-- A window function calculates across related rows while keeping
-- each input row in the result.
--
-- Purpose:
-- Learn row numbering, ranking, and partition-level totals.
--
-- Mental model:
-- Rows -> PARTITION BY group -> ORDER BY within window -> calculate
-- Each original row remains visible.
--
-- Syntax:
-- function(...) OVER (
--   PARTITION BY ...
--   ORDER BY ...
-- )
--
-- Expected result:
-- Each account receives a customer-level row number, an overall rank,
-- and its customer's total balance.
--
-- Key distinction:
-- GROUP BY reduces rows into groups; window functions add calculations
-- to existing rows.
--
-- Performance:
-- Window ORDER BY operations can require sorting. Indexes may help
-- upstream filtering, but the final plan determines actual cost.
--
-- Production use:
-- Running totals, rankings, top-N reports, percentiles, and comparisons.
--
-- Interview:
-- What is the difference between PARTITION BY in a window and GROUP BY?
-- ============================================================

SET search_path TO beginner;

SELECT account_number,customer_id,balance,
       ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY balance DESC) AS row_num,
       RANK() OVER(ORDER BY balance DESC) AS overall_rank,
       SUM(balance) OVER(PARTITION BY customer_id) AS customer_total
FROM accounts;
