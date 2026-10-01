SET search_path TO beginner;
SELECT city,COUNT(*) AS customer_count FROM customers GROUP BY city;
SELECT account_type,COUNT(*) AS accounts,SUM(balance) AS total_balance FROM accounts GROUP BY account_type;