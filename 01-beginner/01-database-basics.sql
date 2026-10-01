-- ============================================================
-- 01 — Database basics: schema, table, columns, keys
-- ============================================================
--
-- Definition:
-- A table is a structured collection of rows. Each column describes
-- one attribute, and a primary key uniquely identifies each row.
--
-- Purpose:
-- Build the first customer table and introduce common constraints.
--
-- Mental model:
-- Customer -> one row
-- first_name / email / city -> attributes of that customer
-- customer_id -> stable identifier
--
-- Key concepts:
-- * BIGSERIAL: generates increasing numeric identifiers.
-- * PRIMARY KEY: unique and non-null row identifier.
-- * NOT NULL: a value is required.
-- * UNIQUE: prevents duplicate values.
-- * DEFAULT: supplies a value when one is not provided.
--
-- Expected result:
-- The final query lists tables inside the beginner schema and should
-- include customers.
--
-- Practice:
-- Add a phone column with an appropriate data type and decide whether
-- it should allow NULL or duplicate values.
--
-- Edge case:
-- UNIQUE does not mean "required"; NULL handling has its own rules.
--
-- Production use:
-- Good table definitions protect data quality before application code
-- ever sees the data.
--
-- Interview:
-- Why should an application table usually have a primary key?
-- ============================================================

CREATE SCHEMA IF NOT EXISTS beginner;
SET search_path TO beginner;

CREATE TABLE customers (
    customer_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE,
    date_of_birth DATE,
    city VARCHAR(80),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Inspect the tables created in the beginner schema.
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'beginner';
