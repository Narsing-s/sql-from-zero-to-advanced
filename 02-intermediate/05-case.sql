SET search_path TO beginner;
SELECT account_number,balance,CASE WHEN balance>=50000 THEN 'PREMIUM' WHEN balance>=20000 THEN 'GOLD' ELSE 'STANDARD' END AS segment FROM accounts;