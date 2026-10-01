-- ============================================================
-- 01 — NULL and three-valued logic
-- ============================================================
--
-- Definition:
-- NULL represents an unknown, missing, or inapplicable value. SQL
-- comparisons involving NULL use three-valued logic: TRUE, FALSE,
-- or UNKNOWN.
--
-- Purpose:
-- Understand why NULL behaves differently from zero, empty strings,
-- and ordinary values.
--
-- Mental model:
-- NULL -> comparison -> UNKNOWN
-- NULL -> IS NULL -> TRUE
-- NULL -> COALESCE -> chosen fallback value
--
-- Key rules:
-- * NULL = NULL is UNKNOWN, not TRUE.
-- * IS NULL tests for NULL.
-- * IS DISTINCT FROM provides NULL-safe comparison.
-- * COALESCE returns the first non-NULL expression.
--
-- Expected result:
-- The first expression returns NULL; IS NULL returns true; the
-- NULL-safe comparison returns false; COALESCE returns 'Unknown'.
--
-- Common mistake:
-- Never use column = NULL when you mean "column is missing."
--
-- Performance/security/production:
-- NULL semantics affect filters, joins, constraints, reports, and
-- application data validation. Make missing-value behavior explicit.
--
-- Interview:
-- Why does WHERE column = NULL return no matching rows?
-- ============================================================

SELECT NULL = NULL;
SELECT NULL IS NULL;
SELECT NULL IS DISTINCT FROM NULL;

SELECT COALESCE(NULL, 'Unknown') AS display_name;

SELECT
  customer_id,
  CASE WHEN email IS NULL THEN 'Missing' ELSE 'Present' END AS email_state
FROM beginner.customers;
