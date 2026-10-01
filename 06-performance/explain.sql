EXPLAIN SELECT c.first_name,a.balance FROM beginner.customers c JOIN beginner.accounts a USING(customer_id);
EXPLAIN ANALYZE SELECT * FROM beginner.accounts WHERE balance>20000;