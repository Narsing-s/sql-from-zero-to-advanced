-- ============================================================
-- 01 — JOINs: complete JOIN toolkit
-- ============================================================
--
-- Definition:
-- A JOIN combines rows from multiple tables according to a join
-- condition. Different JOIN types determine which unmatched rows
-- are preserved.
--
-- Mental model:
-- INNER = matches only
-- LEFT  = all left + matches
-- RIGHT = all right + matches
-- FULL  = all rows from both sides
-- CROSS = every possible pair
-- SELF  = a table joined to itself
--
-- Core relationship:
-- customers.customer_id <-> accounts.customer_id
--
-- 1. INNER JOIN
-- Returns rows with a match on both sides.
SELECT c.customer_id, c.first_name, a.account_number, a.balance
FROM customers c
INNER JOIN accounts a
    ON a.customer_id = c.customer_id;

-- 2. LEFT JOIN
-- Keeps every customer, even if that customer has no account.
SELECT c.customer_id, c.first_name, a.account_number
FROM customers c
LEFT JOIN accounts a
    ON a.customer_id = c.customer_id;

-- Find unmatched customers.
SELECT c.customer_id, c.first_name
FROM customers c
LEFT JOIN accounts a
    ON a.customer_id = c.customer_id
WHERE a.account_id IS NULL;

-- 3. RIGHT JOIN
-- Keeps every account row and matching customers.
-- LEFT JOIN is often preferred because it is easier to read by
-- choosing the important table as the left side.
SELECT c.first_name, a.account_number
FROM customers c
RIGHT JOIN accounts a
    ON a.customer_id = c.customer_id;

-- 4. FULL OUTER JOIN
-- Keeps matched and unmatched rows from both sides.
SELECT c.customer_id, c.first_name, a.account_number
FROM customers c
FULL OUTER JOIN accounts a
    ON a.customer_id = c.customer_id;

-- 5. CROSS JOIN
-- Produces the Cartesian product: every customer paired with every
-- account. Use intentionally because row counts can grow rapidly.
SELECT c.first_name, a.account_number
FROM customers c
CROSS JOIN accounts a;

-- 6. SELF JOIN
-- A table can be joined to itself. This is common for hierarchies
-- such as employee -> manager. Example pattern:
--
-- SELECT e.name AS employee, m.name AS manager
-- FROM employees e
-- LEFT JOIN employees m ON m.employee_id = e.manager_id;
--
-- 7. JOIN multiplication
-- If one customer has 3 accounts and another table has 4 transactions
-- for those accounts, joining both detail tables can produce multiple
-- rows per customer. Always understand the grain of each table.
--
-- 8. EXISTS when you only need to test whether a related row exists.
SELECT c.customer_id, c.first_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
);

-- Common mistakes:
-- * joining on the wrong key
-- * accidentally turning a LEFT JOIN into an INNER JOIN by filtering
--   the right table in WHERE instead of ON
-- * ignoring one-to-many row multiplication
-- * using CROSS JOIN without calculating expected row count
--
-- Performance:
-- Inspect EXPLAIN for large joins. Join performance depends on
-- cardinality, statistics, indexes, filters, memory and join algorithm.
--
-- Production:
-- APIs, reports, reconciliation, customer/account views and analytics
-- routinely combine related tables.
--
-- Practice:
-- 1. Return customers with no accounts.
-- 2. Return every account with its customer if present.
-- 3. Produce all customer/account combinations and predict the row count.
-- 4. Explain why EXISTS may be preferable when only existence matters.
--
-- Interview:
-- Q: INNER JOIN vs LEFT JOIN?
-- A: INNER keeps only matching rows; LEFT preserves every left row.
--
-- Q: Why can a JOIN unexpectedly increase row count?
-- A: A one-to-many or many-to-many relationship can produce multiple
--    result rows for a single logical entity.
