SET search_path TO beginner;

SELECT * FROM customers;
SELECT customer_id, first_name, email FROM customers;
SELECT DISTINCT city FROM customers;
SELECT * FROM customers ORDER BY first_name;
SELECT * FROM customers ORDER BY customer_id DESC LIMIT 3;
