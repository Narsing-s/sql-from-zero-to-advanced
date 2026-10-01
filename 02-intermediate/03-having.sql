SET search_path TO beginner;
SELECT account_type,SUM(balance) AS total_balance FROM accounts GROUP BY account_type HAVING SUM(balance)>20000;