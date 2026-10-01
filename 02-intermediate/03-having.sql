-- ============================================================
-- 03 — HAVING: filtering groups
-- ============================================================
--
-- Definition:
-- HAVING filters groups after aggregation, whereas WHERE filters
-- individual rows before grouping.
--
-- Purpose:
-- Learn how to keep only aggregated groups that meet a condition.
--
-- Mental model:
-- Rows -> WHERE -> GROUP BY -> aggregate -> HAVING -> result
--
-- Syntax:
-- SELECT group_column, AGG(value)
-- FROM table
-- GROUP BY group_column
-- HAVING aggregate_condition;
--
-- Expected result:
-- Only account types whose total balance is greater than 20,000 appear.
--
-- Practice:
-- Change the threshold and predict how many groups should remain.
--
-- Common mistake:
-- Using HAVING for a simple row filter when WHERE can filter earlier.
--
-- Performance:
-- Filtering rows with WHERE before GROUP BY can reduce the amount of
-- data that must be aggregated.
--
-- Production use:
-- Useful for detecting high-value customer groups, threshold breaches,
-- and summary-level business rules.
--
-- Interview:
-- Why can't a normal aggregate filter usually be placed in WHERE?
-- ============================================================

SET search_path TO beginner;

SELECT account_type,SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type
HAVING SUM(balance)>20000;
