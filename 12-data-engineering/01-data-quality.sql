-- ============================================================
-- 01 — Data quality checks
-- ============================================================
--
-- Definition:
-- Data quality means data is fit for its intended use: complete,
-- valid, consistent, unique where required, and correctly related.
--
-- Purpose:
-- Demonstrate SQL checks for missing values, duplicate business keys,
-- and broken relationships.
--
-- Mental model:
-- Raw data -> quality rule -> exception rows/metrics -> action
--
-- Expected result:
-- The first query reports missing-email volume. The second finds
-- duplicate emails. The third finds accounts whose customer relationship
-- is missing.
--
-- Important:
-- A quality query should clearly define what "bad" means. Some NULLs
-- or duplicates can be legitimate depending on the business rule.
--
-- Practice:
-- Add checks for negative balances, invalid statuses, and impossible
-- dates.
--
-- Performance:
-- Run expensive quality scans against appropriate staging/warehouse
-- tables or schedule them according to data volume and SLA.
--
-- Production use:
-- Quality checks belong in ingestion pipelines, monitoring, and release
-- validation rather than only in manual troubleshooting.
--
-- Interview:
-- How would you detect duplicate business keys with SQL?
-- ============================================================

SELECT
  COUNT(*) AS total_rows,
  COUNT(*) FILTER (WHERE email IS NULL) AS missing_email,
  ROUND(
    100.0 * COUNT(*) FILTER (WHERE email IS NULL) /
    NULLIF(COUNT(*),0), 2
  ) AS missing_email_pct
FROM beginner.customers;

SELECT email, COUNT(*)
FROM beginner.customers
GROUP BY email
HAVING COUNT(*) > 1;

SELECT a.account_id
FROM bank.accounts a
LEFT JOIN bank.customers c ON c.customer_id = a.customer_id
WHERE c.customer_id IS NULL;
