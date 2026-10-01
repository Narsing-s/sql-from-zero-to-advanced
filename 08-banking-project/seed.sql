-- ============================================================
-- Banking project — seed data
-- ============================================================
--
-- Definition:
-- Seed data is controlled sample data used to make a database useful
-- for development, learning, testing, and demonstrations.
--
-- Purpose:
-- Populate the banking schema in dependency order.
--
-- Mental model:
-- Parent rows first -> child rows next
-- branches/customers -> accounts -> later transactions/loans
--
-- Expected result:
-- Three branches, five customers, and five accounts are created.
--
-- Important:
-- This script uses explicit IDs in account relationships. It assumes
-- the database was initialized with the matching sequence values.
-- In production or reusable fixtures, prefer selecting IDs by stable
-- business keys or use a controlled reset/fixture strategy.
--
-- Common mistake:
-- Re-running seed data can violate UNIQUE constraints such as email,
-- branch_code, account_number, or IFSC code.
--
-- Practice:
-- Add a sixth customer and account, then write a query to verify the
-- relationship.
--
-- Production use:
-- Production data loading normally uses migrations, controlled fixtures,
-- COPY/bulk loading, staging, validation, and idempotent processes.
--
-- Interview:
-- Why should related seed data usually be inserted in dependency order?
-- ============================================================

INSERT INTO bank.branches(branch_code,branch_name,city,ifsc_code)
VALUES
('VSK001','Visakhapatnam Main','Visakhapatnam','BANK0001001'),
('HYD001','Hyderabad Main','Hyderabad','BANK0001002'),
('VJA001','Vijayawada Main','Vijayawada','BANK0001003');

INSERT INTO bank.customers(first_name,last_name,email,phone,date_of_birth)
VALUES
('Ravi','Kumar','ravi.bank@example.com','9876543210','1995-05-10'),
('Anita','Rao','anita.bank@example.com','9876543211','1992-08-21'),
('Kiran','Sharma','kiran.bank@example.com','9876543212','1998-01-15'),
('Priya','Reddy','priya.bank@example.com','9876543213','1990-12-05'),
('Arjun','Naidu','arjun.bank@example.com','9876543214','1988-03-30');

INSERT INTO bank.accounts(customer_id,branch_id,account_number,account_type,balance)
VALUES
(1,1,'SB100001','SAVINGS',50000),
(2,2,'SB100002','SAVINGS',75000),
(3,3,'CA100003','CURRENT',120000),
(4,1,'SB100004','SAVINGS',25000),
(5,2,'CA100005','CURRENT',150000);
