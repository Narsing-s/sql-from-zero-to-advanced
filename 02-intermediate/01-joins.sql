SET search_path TO beginner;
SELECT c.customer_id,c.first_name,a.account_number,a.balance FROM customers c JOIN accounts a ON a.customer_id=c.customer_id;
SELECT c.* FROM customers c LEFT JOIN accounts a ON a.customer_id=c.customer_id WHERE a.account_id IS NULL;