SET search_path TO beginner;

SELECT * FROM customers WHERE email IS NULL;
SELECT * FROM customers WHERE email IS NOT NULL;
SELECT COALESCE(email, 'NO EMAIL') AS email_display FROM customers;
