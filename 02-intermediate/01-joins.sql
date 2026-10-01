-- ============================================================
-- 01 — JOINs: combining related tables
-- ============================================================
--
-- Definition:
-- A JOIN combines rows from multiple tables using a relationship
-- between their columns.
--
-- Purpose:
-- Learn INNER JOIN for matching data and LEFT JOIN for preserving
-- every row from the left table.
--
-- Mental model:
-- customers.customer_id <-> accounts.customer_id
-- INNER JOIN = matching pairs
-- LEFT JOIN  = every customer + matching account when one exists
--
-- Syntax:
-- SELECT ...
-- FROM left_table l
-- JOIN right_table r ON r.key = l.key;
--
-- Expected result:
-- The first query returns customers with accounts. The second finds
-- customers that have no matching account.
--
-- Line-by-line:
-- c and a are table aliases; ON defines the matching relationship.
-- In the LEFT JOIN query, a.account_id IS NULL identifies unmatched rows.
--
-- Common mistakes:
-- Joining on the wrong column can create incorrect row multiplication.
--
-- Performance:
-- Index frequently joined foreign-key columns when workload and data
-- volume justify it.
--
-- Production use:
-- APIs and reports commonly combine customer, account, order, and
-- transaction data with joins.
--
-- Interview:
-- When would you use INNER JOIN versus LEFT JOIN?
-- ============================================================

SET search_path TO beginner;

SELECT c.customer_id,c.first_name,a.account_number,a.balance
FROM customers c
JOIN accounts a ON a.customer_id=c.customer_id;

SELECT c.*
FROM customers c
LEFT JOIN accounts a ON a.customer_id=c.customer_id
WHERE a.account_id IS NULL;
