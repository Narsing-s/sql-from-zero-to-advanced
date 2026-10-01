-- ============================================================
-- 05 — CASE: conditional logic in SQL
-- ============================================================
--
-- Definition:
-- CASE is SQL's conditional expression. It returns a value based on
-- conditions evaluated in order.
--
-- Purpose:
-- Convert business rules into derived labels or values without moving
-- every rule into application code.
--
-- Mental model:
-- value -> first true condition -> returned result -> alias
--
-- Syntax:
-- CASE
--   WHEN condition THEN result
--   WHEN condition THEN result
--   ELSE default_result
-- END
--
-- Expected result:
-- Each account is classified as PREMIUM, GOLD, or STANDARD according
-- to its balance.
--
-- Edge case:
-- Conditions are checked top-to-bottom. Overlapping conditions can
-- therefore change the result.
--
-- Practice:
-- Add a new segment for balances below 10,000.
--
-- Production use:
-- Common for reporting labels, risk bands, status mapping, and metrics.
--
-- Interview:
-- In what order are CASE WHEN conditions evaluated?
-- ============================================================

SET search_path TO beginner;

SELECT account_number,balance,
       CASE
           WHEN balance>=50000 THEN 'PREMIUM'
           WHEN balance>=20000 THEN 'GOLD'
           ELSE 'STANDARD'
       END AS segment
FROM accounts;
