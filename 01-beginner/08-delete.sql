SET search_path TO beginner;

-- Always verify the WHERE clause with SELECT before DELETE.
SELECT * FROM customers WHERE customer_id = 999;

DELETE FROM customers
WHERE customer_id = 999;
