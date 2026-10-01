-- ============================================================
-- 13 — Data Types and Constraints
-- ============================================================
--
-- Goal:
-- Understand how column types and constraints protect data quality.
--
-- Common PostgreSQL types:
-- integer/bigint     whole numbers
-- numeric(p,s)       exact decimal values such as money
-- varchar/text       text
-- date               calendar date
-- timestamp          date + time
-- boolean            true/false
-- jsonb              semi-structured JSON
--
-- Core constraints:
-- PRIMARY KEY   uniquely identifies a row
-- FOREIGN KEY   enforces a relationship to another table
-- UNIQUE        prevents duplicate values
-- NOT NULL      requires a value
-- CHECK         enforces a business rule
-- DEFAULT       supplies a value when one is omitted
--
-- Production note:
-- Prefer database constraints for invariants that must remain true
-- regardless of which application writes the data.
-- ============================================================

SET search_path TO beginner;

DROP TABLE IF EXISTS type_constraint_lab;

CREATE TABLE type_constraint_lab (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(30) NOT NULL UNIQUE,
    amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    effective_date DATE NOT NULL DEFAULT CURRENT_DATE,
    metadata JSONB NOT NULL DEFAULT '{}'::jsonb
);

INSERT INTO type_constraint_lab(code, amount)
VALUES ('SQL101', 1250.50);

SELECT * FROM type_constraint_lab;

-- Challenge:
-- 1. Try inserting a duplicate code.
-- 2. Try inserting a negative amount.
-- 3. Try inserting NULL into code.
-- 4. Add a CHECK constraint for a business-specific rule.
