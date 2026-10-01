\set ON_ERROR_STOP on
SELECT count(*) AS customer_count FROM ci_lab.customers;
SELECT count(*) AS order_count FROM ci_lab.orders;

DO $$
BEGIN
  IF (SELECT count(*) FROM ci_lab.customers) <> 3 THEN
    RAISE EXCEPTION 'customer fixture assertion failed';
  END IF;

  IF (SELECT count(*) FROM ci_lab.orders) <> 3 THEN
    RAISE EXCEPTION 'order fixture assertion failed';
  END IF;

  IF (SELECT sum(amount) FROM ci_lab.orders) <> 325.50 THEN
    RAISE EXCEPTION 'order total assertion failed';
  END IF;
END $$;

SELECT c.customer_name, count(o.order_id) AS orders, coalesce(sum(o.amount),0) AS total
FROM ci_lab.customers c
LEFT JOIN ci_lab.orders o ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.customer_name
ORDER BY c.customer_id;