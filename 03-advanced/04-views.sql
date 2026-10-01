SET search_path TO beginner;
CREATE OR REPLACE VIEW customer_account_summary AS SELECT c.customer_id,c.first_name,c.last_name,a.account_number,a.account_type,a.balance FROM customers c LEFT JOIN accounts a USING(customer_id);
SELECT * FROM customer_account_summary;