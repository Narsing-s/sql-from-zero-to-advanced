-- ============================================================
-- 14 — Keys and Relationships
-- ============================================================
--
-- Relationship model:
--
-- customers
--   customer_id (PK)
--        |
--        | 1-to-many
--        v
-- accounts
--   customer_id (FK)
--
-- Key concepts:
-- Primary key  -> row identity
-- Foreign key  -> relationship + referential integrity
-- Unique key   -> alternate uniqueness rule
-- Composite key -> uniqueness across multiple columns
--
-- Common relationship types:
-- 1-to-1, 1-to-many, many-to-many.
--
-- Many-to-many relationships are normally represented with a
-- junction/bridge table containing foreign keys to both entities.
-- ============================================================

SET search_path TO beginner;

CREATE TABLE IF NOT EXISTS customer_profiles (
    customer_id BIGINT PRIMARY KEY REFERENCES customers(customer_id),
    profile_note TEXT
);

CREATE TABLE IF NOT EXISTS customer_tags (
    customer_id BIGINT NOT NULL REFERENCES customers(customer_id),
    tag VARCHAR(40) NOT NULL,
    PRIMARY KEY (customer_id, tag)
);

-- Example relationship query:
SELECT
    c.customer_id,
    c.name,
    a.account_number,
    a.account_type
FROM customers AS c
LEFT JOIN accounts AS a
    ON a.customer_id = c.customer_id
ORDER BY c.customer_id, a.account_number;

-- Challenge:
-- 1. Explain why customer_profiles is one-to-one.
-- 2. Explain why accounts is one-to-many.
-- 3. Explain how customer_tags can represent repeated tags per customer.
