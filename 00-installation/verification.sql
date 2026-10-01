-- ============================================================
-- PostgreSQL verification
-- ============================================================
--
-- Definition:
-- Verification is a small set of read-only checks used to confirm
-- that the client is connected to the expected PostgreSQL instance.
--
-- Purpose:
-- Learn how SQL can inspect the current execution environment
-- before you start creating application data.
--
-- Mental model:
-- Connect -> Identify database/user -> Identify server version
--
-- Syntax:
-- SELECT expression AS alias;
--
-- Expected result:
-- Three rows/columns of information: database name, current user,
-- and PostgreSQL server version.
--
-- Practice:
-- Run the script after connecting to another database and compare
-- current_database() with your expected database.
--
-- Common mistake:
-- Checking the PostgreSQL client version instead of the server version.
--
-- Production use:
-- Similar checks help diagnose connection and environment problems.
--
-- Interview:
-- How can you identify the database and user for the current session?
-- ============================================================

SELECT current_database() AS database_name;
SELECT current_user AS database_user;
SELECT version() AS postgresql_version;
