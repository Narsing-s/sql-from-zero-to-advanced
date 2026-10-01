-- ============================================================
-- Indexes: helping PostgreSQL find rows efficiently
-- ============================================================
--
-- Definition:
-- An index is an additional data structure that can help the database
-- locate matching rows without scanning every table row.
--
-- Purpose:
-- Learn simple and multicolumn indexes and verify a query with EXPLAIN.
--
-- Mental model:
-- Query predicate -> planner -> possible index scan -> table rows
--
-- Syntax:
-- CREATE INDEX index_name ON table(column);
-- CREATE INDEX index_name ON table(column1,column2);
--
-- Expected result:
-- Indexes are created if absent. EXPLAIN ANALYZE then shows the actual
-- execution plan for an email lookup.
--
-- Important trade-off:
-- Indexes can speed reads but consume storage and add write/update cost.
--
-- Practice:
-- Compare EXPLAIN plans before and after creating an index on a larger
-- dataset. Do not expect an index to be used for every query.
--
-- Common mistakes:
-- * Indexing every column.
-- * Ignoring column order in multicolumn indexes.
-- * Assuming an index guarantees faster execution.
--
-- Production use:
-- Index based on real access patterns, data distribution, and measured
-- execution plans.
--
-- Interview:
-- Why can adding an index make INSERT/UPDATE operations more expensive?
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_customers_email
ON beginner.customers(email);

CREATE INDEX IF NOT EXISTS idx_accounts_customer_balance
ON beginner.accounts(customer_id,balance);

EXPLAIN ANALYZE
SELECT * FROM beginner.customers WHERE email='ravi@example.com';
