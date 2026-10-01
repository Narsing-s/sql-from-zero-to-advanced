SET search_path TO beginner;

UPDATE customers
SET city = 'Visakhapatnam'
WHERE customer_id = 2;

SELECT * FROM customers WHERE customer_id = 2;
