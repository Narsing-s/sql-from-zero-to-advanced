-- ============================================================
-- PostgreSQL setup: first learning database objects
-- ============================================================
--
-- Definition:
-- A schema is a namespace inside a PostgreSQL database. A table
-- stores related rows and columns.
--
-- Purpose:
-- Create a small, repeatable environment that proves PostgreSQL
-- is installed and that SQL statements can be executed.
--
-- Mental model:
-- Database -> Schema -> Table -> Row -> Column -> Value
--
-- Syntax:
-- CREATE SCHEMA IF NOT EXISTS schema_name;
-- CREATE TABLE table_name (...);
--
-- Example:
-- The script creates a learning schema and an installation_check
-- table, then inserts one verification row.
--
-- Expected result:
-- version() shows the PostgreSQL version and the final SELECT
-- shows the latest environment-check row.
--
-- Practice:
-- Change the message and run the script again. Observe that the
-- table is reused because IF NOT EXISTS is present.
--
-- Common mistakes:
-- * Running the script in a database where you lack CREATE rights.
-- * Forgetting to set the intended schema/search_path.
--
-- Production use:
-- Setup/migration scripts create predictable database structures.
--
-- Interview:
-- What is the difference between a PostgreSQL database and schema?
-- ============================================================

CREATE SCHEMA IF NOT EXISTS learning;
SET search_path TO learning;

CREATE TABLE IF NOT EXISTS installation_check (
    id BIGSERIAL PRIMARY KEY,
    checked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    message TEXT NOT NULL
);

INSERT INTO installation_check (message)
VALUES ('PostgreSQL learning environment is ready');

SELECT version();
SELECT * FROM installation_check ORDER BY id DESC;
