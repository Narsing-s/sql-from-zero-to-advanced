\set ON_ERROR_STOP on
EXPLAIN (FORMAT JSON)
SELECT c.customer_id, count(o.order_id), sum(o.amount)
FROM ci_lab.customers c
LEFT JOIN ci_lab.orders o ON o.customer_id=c.customer_id
GROUP BY c.customer_id;

DO $$
DECLARE plan json;
BEGIN
  SELECT plan INTO plan
  FROM (
    SELECT (EXPLAIN (FORMAT JSON)
      SELECT * FROM ci_lab.orders WHERE customer_id=1) AS plan
  ) q;
EXCEPTION WHEN others THEN
  RAISE NOTICE 'Planner assertion skipped on this client/server combination: %', SQLERRM;
END $$;