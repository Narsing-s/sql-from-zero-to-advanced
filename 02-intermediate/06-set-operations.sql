-- 06 — Set operations: combining compatible result sets
--
-- Definition:
-- Set operations combine the results of SELECT statements.
--
-- UNION removes duplicate rows; UNION ALL keeps duplicates.
-- INTERSECT returns rows common to both queries.
-- EXCEPT returns rows from the first query that are absent from the second.
--
-- Mental model:
-- SELECT A + SELECT B -> combine/compare result sets
--
-- UNION
SELECT city FROM beginner.customers
UNION
SELECT city FROM beginner.customers WHERE city IS NOT NULL;

-- UNION ALL keeps duplicates.
SELECT city FROM beginner.customers
UNION ALL
SELECT city FROM beginner.customers WHERE city IS NOT NULL;

-- INTERSECT
SELECT city FROM beginner.customers
INTERSECT
SELECT city FROM beginner.customers WHERE city LIKE 'V%';

-- EXCEPT
SELECT city FROM beginner.customers
EXCEPT
SELECT city FROM beginner.customers WHERE city LIKE 'V%';

-- Rules:
-- SELECT lists must have compatible column counts and compatible types.
-- ORDER BY normally belongs to the final combined result.
--
-- Production:
-- Useful for reconciliation, comparison, reporting and combining
-- independently filtered datasets.
--
-- Practice:
-- 1. Find cities present in both two result sets.
-- 2. Explain UNION vs UNION ALL.
-- 3. Use EXCEPT to identify missing values.