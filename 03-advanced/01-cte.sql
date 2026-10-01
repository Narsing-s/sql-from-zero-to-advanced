SET search_path TO beginner;
WITH customer_balances AS (SELECT customer_id,SUM(balance) total_balance FROM accounts GROUP BY customer_id)
SELECT c.first_name,cb.total_balance FROM customers c JOIN customer_balances cb USING(customer_id) WHERE cb.total_balance>20000;