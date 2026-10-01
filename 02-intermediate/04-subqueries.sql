-- ============================================================
-- 04 — Subqueries: queries inside queries
-- ============================================================
--
-- Definition:
-- A subquery is a query nested inside another SQL statement.
--
-- Purpose:
-- Use a query's result as input for another query.
--
-- Mental model:
-- Inner query -> produces values -> outer query uses those values
--
-- Syntax:
-- SELECT ... WHERE column IN (SELECT ...);
-- SELECT ... WHERE column > (SELECT aggregate ...);
--
-- Expected result:
-- The first query finds customers with an account balance over 30,000.
-- The second finds accounts above the overall average balance.
--
-- Common mistake:
-- Make sure the subquery returns the number/type of values required by
-- the operator (for example, IN expects a set of values).
--
-- Performance:
-- PostgreSQL may transform some subqueries into joins or other efficient
-- plans; inspect EXPLAIN rather than assuming they are slow.
--
-- Production use:
-- Useful for existence checks, thresholds, filtering, and reporting.
--
-- Interview:
-- When would EXISTS be preferable to IN?
-- ============================================================

SET search_path TO beginner;

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM accounts WHERE balance > 30000
);

SELECT *
FROM accounts
WHERE balance > (SELECT AVG(balance) FROM accounts);
