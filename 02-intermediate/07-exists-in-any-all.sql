-- 07 — EXISTS, IN, ANY and ALL
--
-- Definition:
-- These predicates compare a value with a subquery result or test
-- whether related rows exist.
--
-- EXISTS tests whether at least one related row exists.
SELECT c.customer_id, c.first_name
FROM beginner.customers c
WHERE EXISTS (
    SELECT 1 FROM beginner.accounts a
    WHERE a.customer_id = c.customer_id
);

-- NOT EXISTS finds customers without a matching account.
SELECT c.customer_id, c.first_name
FROM beginner.customers c
WHERE NOT EXISTS (
    SELECT 1 FROM beginner.accounts a
    WHERE a.customer_id = c.customer_id
);

-- IN compares against a set of values.
SELECT *
FROM beginner.accounts
WHERE customer_id IN (
    SELECT customer_id FROM beginner.customers
);

-- ANY means the comparison is true for at least one value.
SELECT *
FROM beginner.accounts
WHERE balance > ANY (
    SELECT balance FROM beginner.accounts WHERE balance > 0
);

-- ALL means the comparison must be true for every value.
SELECT *
FROM beginner.accounts
WHERE balance >= ALL (
    SELECT balance FROM beginner.accounts
);

-- NULL note:
-- NOT IN can behave unexpectedly when the subquery contains NULL.
-- NOT EXISTS is often safer for anti-join logic.
--
-- Performance:
-- PostgreSQL may transform EXISTS/IN into semi-join or anti-join plans.
-- Use EXPLAIN for real workloads.
--
-- Practice:
-- Find customers with accounts, customers without accounts, and
-- accounts whose balance exceeds every positive account balance.