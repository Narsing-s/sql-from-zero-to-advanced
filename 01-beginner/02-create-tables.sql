-- ============================================================
-- 02 — CREATE TABLE: relationships and constraints
-- ============================================================
--
-- Definition:
-- CREATE TABLE defines the structure of a table. Constraints enforce
-- rules that keep stored data valid.
--
-- Purpose:
-- Create accounts and connect every account to an existing customer.
--
-- Mental model:
-- customers (parent) 1 ---- many accounts (child)
-- customer_id is the link between the two tables.
--
-- Key concepts:
-- * FOREIGN KEY: requires a referenced parent row to exist.
-- * CHECK: rejects values that violate a business rule.
-- * DEFAULT: supplies a value automatically.
-- * NUMERIC(15,2): stores exact decimal values, useful for money.
--
-- Expected result:
-- An accounts table exists in the beginner schema with a customer
-- relationship and validation rules.
--
-- Practice:
-- Try to insert an account with a negative balance or invalid
-- account_type and observe the constraint error.
--
-- Common mistake:
-- Using floating-point types for exact financial amounts.
--
-- Production use:
-- Constraints are a database-level safety net; do not rely only on
-- application validation.
--
-- Interview:
-- What is the difference between a primary key and a foreign key?
-- ============================================================

SET search_path TO beginner;

CREATE TABLE IF NOT EXISTS accounts (
    account_id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES customers(customer_id),
    account_number VARCHAR(30) UNIQUE NOT NULL,
    account_type VARCHAR(20) NOT NULL CHECK (account_type IN ('SAVINGS','CURRENT')),
    balance NUMERIC(15,2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
    opened_at DATE NOT NULL DEFAULT CURRENT_DATE
);
