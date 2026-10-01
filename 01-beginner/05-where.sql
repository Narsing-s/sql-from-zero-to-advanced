-- ============================================================
-- 05 — WHERE: filtering rows
-- ============================================================
--
-- Definition:
-- WHERE applies a condition to each candidate row and keeps rows
-- for which the condition evaluates to TRUE.
--
-- Purpose:
-- Learn equality, comparisons, IN, LIKE, and BETWEEN.
--
-- Mental model:
-- Table -> evaluate condition -> keep matching rows
--
-- Syntax:
-- SELECT ... FROM table WHERE condition;
--
-- Expected result:
-- Each query returns only customers/accounts matching its condition.
--
-- Practice:
-- Find customers in Hyderabad whose first name starts with "A".
--
-- Edge cases:
-- NULL is not equal to anything with =. Use IS NULL or IS NOT NULL.
-- LIKE patterns depend on the pattern; A% means "starts with A".
--
-- Performance:
-- A filter may use an appropriate index when the predicate is
-- selective and written in an index-friendly form.
--
-- Security:
-- In application code, pass user values as parameters rather than
-- concatenating them into SQL strings.
--
-- Interview:
-- What is the difference between WHERE and HAVING?
-- ============================================================

SET search_path TO beginner;

SELECT * FROM customers WHERE city = 'Hyderabad';
SELECT * FROM customers WHERE date_of_birth >= '1995-01-01';
SELECT * FROM customers WHERE city IN ('Hyderabad','Visakhapatnam');
SELECT * FROM customers WHERE first_name LIKE 'A%';
SELECT * FROM accounts WHERE balance BETWEEN 10000 AND 50000;
