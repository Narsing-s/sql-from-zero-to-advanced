-- ============================================================
-- 04 — SELECT: reading and shaping result sets
-- ============================================================
--
-- Definition:
-- SELECT retrieves data and determines which columns and rows appear
-- in the result.
--
-- Purpose:
-- Learn projection (columns), DISTINCT, sorting, and limiting results.
--
-- Mental model:
-- Table -> SELECT columns -> optional DISTINCT -> ORDER BY -> LIMIT
--
-- Syntax:
-- SELECT column1, column2 FROM table WHERE ... ORDER BY ... LIMIT ...;
--
-- Expected result:
-- The examples show all customers, selected columns, unique cities,
-- sorted customers, and the first three customers in descending ID order.
--
-- Practice:
-- Select only first_name and city, sort by city, then return five rows.
--
-- Common mistakes:
-- * Using SELECT * in application code when only a few columns are needed.
-- * Assuming row order without ORDER BY.
--
-- Performance:
-- Selecting only required columns can reduce data transfer and work.
--
-- Production use:
-- SELECT is the foundation of reports, APIs, dashboards, and diagnostics.
--
-- Interview:
-- Why is ORDER BY required when you need deterministic result ordering?
-- ============================================================

SET search_path TO beginner;

SELECT * FROM customers;
SELECT customer_id, first_name, email FROM customers;
SELECT DISTINCT city FROM customers;
SELECT * FROM customers ORDER BY first_name;
SELECT * FROM customers ORDER BY customer_id DESC LIMIT 3;
