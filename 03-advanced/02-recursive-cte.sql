-- ============================================================
-- 02 — Recursive CTEs: working with iterative relationships
-- ============================================================
--
-- Definition:
-- A recursive CTE repeatedly evaluates a query, using rows produced
-- by an earlier iteration, until the recursive condition stops.
--
-- Purpose:
-- Learn the anchor member + recursive member pattern used for
-- hierarchies, trees, graphs, and sequence generation.
--
-- Mental model:
-- Anchor row -> recursive step -> next rows -> stop condition
--
-- Syntax:
-- WITH RECURSIVE name AS (
--   anchor_query
--   UNION ALL
--   recursive_query
-- )
-- SELECT * FROM name;
--
-- Expected result:
-- Numbers 1 through 10.
--
-- Edge case:
-- Every recursive query needs a termination condition or another safe
-- mechanism to prevent unbounded recursion.
--
-- Production use:
-- Useful for employee hierarchies, category trees, bill-of-materials,
-- folder structures, and dependency chains.
--
-- Interview:
-- What are the anchor and recursive members of a recursive CTE?
-- ============================================================

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM numbers WHERE n<10
)
SELECT * FROM numbers;
