-- ============================================================
-- 03 — INSERT: adding rows to relational tables
-- ============================================================
--
-- Definition:
-- INSERT adds new rows to a table.
--
-- Purpose:
-- Load realistic sample customers, then create related accounts
-- using the generated customer identifiers.
--
-- Mental model:
-- INSERT columns -> values -> new row
-- Then:
-- customers.customer_id -> accounts.customer_id
--
-- Syntax:
-- INSERT INTO table (column1, column2)
-- VALUES (value1, value2);
--
-- Expected result:
-- Five customer rows are inserted. The second INSERT derives one
-- account row per customer and generates account numbers such as
-- ACC000001.
--
-- Line-by-line idea:
-- * Column lists make the target fields explicit.
-- * VALUES supplies literal customer data.
-- * SELECT reads generated customer IDs for the related accounts.
-- * CASE chooses SAVINGS/CURRENT from the customer ID.
-- * LPAD formats the account number.
--
-- Practice:
-- Add another customer and run a SELECT to verify the new row.
--
-- Edge case:
-- Re-running this script can create duplicate sample customers unless
-- the data model or load process deliberately prevents them.
--
-- Production use:
-- Bulk loads commonly use INSERT ... SELECT, COPY, or staging tables.
--
-- Interview:
-- Why is INSERT ... SELECT useful when loading related data?
-- ============================================================

SET search_path TO beginner;

INSERT INTO customers (first_name,last_name,email,date_of_birth,city) VALUES
('Ravi','Kumar','ravi@example.com','1995-05-10','Visakhapatnam'),
('Anita','Rao','anita@example.com','1992-08-21','Hyderabad'),
('Kiran','Sharma','kiran@example.com','1998-01-15','Vijayawada'),
('Priya','Reddy','priya@example.com','1990-12-05','Visakhapatnam'),
('Arjun','Naidu','arjun@example.com','1988-03-30','Hyderabad');

-- INSERT ... SELECT uses existing customer IDs to create related rows.
INSERT INTO accounts (customer_id,account_number,account_type,balance)
SELECT customer_id,'ACC' || LPAD(customer_id::text,6,'0'),
       CASE WHEN customer_id % 2 = 0 THEN 'CURRENT' ELSE 'SAVINGS' END,
       customer_id * 10000
FROM customers;
