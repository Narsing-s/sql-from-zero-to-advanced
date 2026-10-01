-- NULL is not zero and not an empty string.
-- Comparisons with NULL produce UNKNOWN.
SELECT NULL = NULL; -- NULL
SELECT NULL IS NULL; -- true
SELECT NULL IS DISTINCT FROM NULL; -- false

-- Safe NULL handling.
SELECT COALESCE(NULL, 'Unknown') AS display_name;

-- Conditional NULL logic.
SELECT
  customer_id,
  CASE WHEN email IS NULL THEN 'Missing' ELSE 'Present' END AS email_state
FROM beginner.customers;
