\set ON_ERROR_STOP on
EXPLAIN (FORMAT JSON)
SELECT c.customer_id, count(o.order_id), sum(o.amount)
FROM ci_lab.customers c
LEFT JOIN ci_lab.orders o ON o.customer_id=c.customer_id
GROUP BY c.customer_id;

SELECT count(*) AS customer_id_1_rows FROM ci_lab.orders WHERE customer_id=1;