-- ============================================================
-- 02 — GROUP BY: turning rows into groups
-- ============================================================
--
-- Definition:
-- GROUP BY partitions rows into groups with the same grouping key,
-- allowing aggregate functions to calculate one result per group.
--
-- Purpose:
-- Learn COUNT and SUM and understand how detail rows become summaries.
--
-- Mental model:
-- Rows -> group by key -> aggregate each group -> result row per group
--
-- Syntax:
-- SELECT group_column, AGG(value)
-- FROM table
-- GROUP BY group_column;
--
-- Expected result:
-- The first query counts customers by city. The second counts accounts
-- and sums balances by account type.
--
-- Common mistake:
-- A selected non-aggregated column normally must be included in GROUP BY.
--
-- Performance:
-- Large aggregations may require sorting or hashing and can consume
-- memory; inspect execution plans for expensive workloads.
--
-- Production use:
-- GROUP BY powers dashboards, financial summaries, operational reports,
-- and data-quality checks.
--
-- Interview:
-- What is the difference between GROUP BY and a window function?
-- ============================================================

SET search_path TO beginner;

SELECT city,COUNT(*) AS customer_count
FROM customers
GROUP BY city;

SELECT account_type,COUNT(*) AS accounts,SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type;
