SET search_path TO beginner;

SELECT * FROM customers WHERE city = 'Hyderabad';
SELECT * FROM customers WHERE date_of_birth >= '1995-01-01';
SELECT * FROM customers WHERE city IN ('Hyderabad','Visakhapatnam');
SELECT * FROM customers WHERE first_name LIKE 'A%';
SELECT * FROM accounts WHERE balance BETWEEN 10000 AND 50000;
