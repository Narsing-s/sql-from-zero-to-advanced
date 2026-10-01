CREATE INDEX IF NOT EXISTS idx_customers_email ON beginner.customers(email);
CREATE INDEX IF NOT EXISTS idx_accounts_customer_balance ON beginner.accounts(customer_id,balance);
EXPLAIN ANALYZE SELECT * FROM beginner.customers WHERE email='ravi@example.com';