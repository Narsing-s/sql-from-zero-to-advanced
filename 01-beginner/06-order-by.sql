SET search_path TO beginner;

SELECT * FROM accounts ORDER BY balance DESC;
SELECT * FROM customers ORDER BY city ASC, last_name ASC;
SELECT * FROM accounts ORDER BY balance DESC LIMIT 2 OFFSET 1;
