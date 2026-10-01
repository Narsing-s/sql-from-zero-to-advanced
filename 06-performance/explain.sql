-- ============================================================
-- EXPLAIN: understanding PostgreSQL query plans
-- ============================================================
--
-- Definition:
-- EXPLAIN shows the execution plan PostgreSQL intends to use.
-- EXPLAIN ANALYZE executes the query and reports actual runtime data.
--
-- Purpose:
-- Learn how to inspect scans, joins, estimated rows, actual rows,
-- and execution time.
--
-- Mental model:
-- SQL -> planner -> estimated plan -> executor -> actual result
--
-- Syntax:
-- EXPLAIN SELECT ...;
-- EXPLAIN ANALYZE SELECT ...;
--
-- Expected result:
-- The first statement shows a planned customer/account join.
-- The second executes a balance filter and reports actual statistics.
--
-- Safety:
-- EXPLAIN ANALYZE executes the statement. Never use it casually on
-- INSERT/UPDATE/DELETE in production without understanding the effect.
--
-- Performance:
-- Compare estimated rows with actual rows. Large differences can
-- indicate stale statistics, skew, or planner assumptions worth checking.
--
-- Practice:
-- Run ANALYZE on the tables, then compare the plan again.
--
-- Production use:
-- Query-plan analysis is a core tool for diagnosing slow SQL.
--
-- Interview:
-- What is the difference between EXPLAIN and EXPLAIN ANALYZE?
-- ============================================================

EXPLAIN
SELECT c.first_name,a.balance
FROM beginner.customers c
JOIN beginner.accounts a USING(customer_id);

EXPLAIN ANALYZE
SELECT * FROM beginner.accounts WHERE balance>20000;
