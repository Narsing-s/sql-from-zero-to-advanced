-- ============================================================
-- Banking project — schema design
-- ============================================================
--
-- Definition:
-- A database schema translates business entities and relationships into
-- tables, keys, constraints, and data types.
--
-- Purpose:
-- Build a realistic banking domain for later SQL lessons and projects.
--
-- Mental model:
-- Customer -> Account -> Transaction
-- Customer -> Loan -> Loan Payment
-- Branch -> Account
-- Any important change -> Audit log
--
-- Design principles:
-- * Primary keys identify rows.
-- * Foreign keys preserve relationships.
-- * UNIQUE protects business identifiers such as email and IFSC.
-- * CHECK constraints enforce valid states and positive amounts.
-- * NUMERIC is used for exact monetary values.
-- * JSONB in audit_logs allows flexible before/after snapshots.
--
-- Expected result:
-- The bank schema contains customers, branches, accounts, transactions,
-- loans, loan payments, and audit logs.
--
-- Practice:
-- Add a beneficiary table and define its relationship to customers.
--
-- Common mistake:
-- A constraint is only useful if its rule matches the real business
-- invariant. Model the business rule explicitly.
--
-- Security:
-- Banking data is sensitive. Access should follow least privilege and
-- sensitive fields should not be exposed unnecessarily.
--
-- Production use:
-- This schema is a teaching model; production banking systems require
-- additional controls, auditability, authorization, and regulatory design.
--
-- Interview:
-- Which constraints here protect financial data integrity?
-- ============================================================

CREATE SCHEMA IF NOT EXISTS bank;

CREATE TABLE bank.customers(
    customer_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(30),
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bank.branches(
    branch_id BIGSERIAL PRIMARY KEY,
    branch_code VARCHAR(20) UNIQUE NOT NULL,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(80) NOT NULL,
    ifsc_code VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE bank.accounts(
    account_id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES bank.customers(customer_id),
    branch_id BIGINT REFERENCES bank.branches(branch_id),
    account_number VARCHAR(30) UNIQUE NOT NULL,
    account_type VARCHAR(20) CHECK(account_type IN('SAVINGS','CURRENT')),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    balance NUMERIC(18,2) DEFAULT 0 CHECK(balance>=0)
);

CREATE TABLE bank.transactions(
    transaction_id BIGSERIAL PRIMARY KEY,
    account_id BIGINT REFERENCES bank.accounts(account_id),
    transaction_type VARCHAR(20) CHECK(transaction_type IN('DEPOSIT','WITHDRAWAL','TRANSFER')),
    amount NUMERIC(18,2) CHECK(amount>0),
    reference_code VARCHAR(60) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bank.loans(
    loan_id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT REFERENCES bank.customers(customer_id),
    loan_type VARCHAR(30) NOT NULL,
    principal NUMERIC(18,2) CHECK(principal>0),
    interest_rate NUMERIC(6,3) CHECK(interest_rate>=0),
    status VARCHAR(20) DEFAULT 'ACTIVE'
);

CREATE TABLE bank.loan_payments(
    payment_id BIGSERIAL PRIMARY KEY,
    loan_id BIGINT REFERENCES bank.loans(loan_id),
    amount NUMERIC(18,2) CHECK(amount>0),
    paid_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bank.audit_logs(
    audit_id BIGSERIAL PRIMARY KEY,
    entity_name VARCHAR(100) NOT NULL,
    entity_id BIGINT,
    action VARCHAR(50) NOT NULL,
    old_data JSONB,
    new_data JSONB,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
