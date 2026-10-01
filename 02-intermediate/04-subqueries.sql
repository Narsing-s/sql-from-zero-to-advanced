SET search_path TO beginner;
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM accounts WHERE balance>30000);
SELECT * FROM accounts WHERE balance>(SELECT AVG(balance) FROM accounts);