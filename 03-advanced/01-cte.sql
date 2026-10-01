-- ============================================================
-- 01 — CTEs: named intermediate query results
-- ============================================================
--
-- Definition:
-- A Common Table Expression (CTE) is a named result set defined with
-- WITH and referenced by the statement that follows it.
--
-- Purpose:
-- Make multi-step SQL easier to read, reason about, and maintain.
--
-- Mental model:
-- accounts -> aggregate per customer -> customer_balances
-- customer_balances + customers -> final result
--
-- Syntax:
-- WITH name AS (query)
-- SELECT ... FROM name;
--
-- Expected result:
-- Customers whose combined account balance is greater than 20,000.
--
-- Common mistake:
-- A CTE is not automatically a permanent table; its scope is the
-- statement containing it.
--
-- Performance:
-- Do not assume a CTE is always faster or slower. PostgreSQL can inline
-- eligible CTEs or materialize them depending on query and options.
--
-- Production use:
-- CTEs are useful for readable reports, data transformations, and
-- breaking complex logic into named steps.
--
-- Interview:
-- What is a CTE, and how does its scope differ from a view?
-- ============================================================

SET search_path TO beginner;

WITH customer_balances AS (
    SELECT customer_id,SUM(balance) AS total_balance
    FROM accounts
    GROUP BY customer_id
)
SELECT c.first_name,cb.total_balance
FROM customers c
JOIN customer_balances cb USING(customer_id)
WHERE cb.total_balance>20000;
