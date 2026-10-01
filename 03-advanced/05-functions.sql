-- ============================================================
-- 05 — Functions: reusable database logic
-- ============================================================
--
-- Definition:
-- A function accepts inputs and returns a value or set of rows.
--
-- Purpose:
-- Encapsulate repeatable database calculations or lookups behind a
-- stable callable interface.
--
-- Mental model:
-- Input -> function logic -> returned value
--
-- Syntax:
-- CREATE FUNCTION name(parameters)
-- RETURNS type
-- LANGUAGE sql|plpgsql
-- AS $$ ... $$;
--
-- Expected result:
-- Calling get_account_balance(1) returns the balance for account 1.
--
-- Common mistake:
-- Functions can become hard-to-test business-logic containers if too
-- much application behavior is placed inside the database.
--
-- Security:
-- Be careful with SECURITY DEFINER functions; use a safe search_path
-- and least-privilege ownership when elevated privileges are required.
--
-- Production use:
-- Useful for reusable calculations, validation helpers, and database APIs.
--
-- Interview:
-- What is the difference between a SQL function and a stored procedure?
-- ============================================================

CREATE OR REPLACE FUNCTION public.get_account_balance(p_account_id BIGINT)
RETURNS NUMERIC
LANGUAGE SQL
AS $$
    SELECT balance
    FROM beginner.accounts
    WHERE account_id=p_account_id;
$$;

SELECT public.get_account_balance(1);
