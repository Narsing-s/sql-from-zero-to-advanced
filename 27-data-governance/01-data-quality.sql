-- Generic data-quality checks
SELECT count(*) AS null_customer_ids FROM customers WHERE id IS NULL;
SELECT email, count(*) FROM customers GROUP BY email HAVING count(*) > 1;
SELECT count(*) AS invalid_amounts FROM transactions WHERE amount <= 0;
-- Adapt names to the project's schema before execution.