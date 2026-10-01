-- ============================================================
-- 06 — Procedures: callable database operations
-- ============================================================
--
-- Definition:
-- A procedure is callable database logic invoked with CALL. Unlike a
-- typical function, it is designed for an operation rather than simply
-- returning a value to an expression.
--
-- Purpose:
-- Demonstrate a reusable operation that changes account balances.
--
-- Mental model:
-- CALL -> procedure -> database changes
--
-- Syntax:
-- CREATE PROCEDURE name(parameters)
-- LANGUAGE ...
-- AS $$ ... $$;
--
-- Expected result:
-- Calling the procedure applies the supplied percentage to every account.
-- The CALL is intentionally commented out so running this lesson does
-- not unexpectedly modify balances.
--
-- Safety:
-- Never run a financial mutation in production without authorization,
-- validation, transaction handling, and appropriate audit controls.
--
-- Production use:
-- Procedures can encapsulate controlled database-side operations and
-- administrative/data-processing workflows.
--
-- Interview:
-- When would a procedure be more appropriate than a function?
-- ============================================================

CREATE OR REPLACE PROCEDURE public.add_interest(p_rate NUMERIC)
LANGUAGE SQL
AS $$
    UPDATE beginner.accounts
    SET balance=ROUND(balance*(1+p_rate/100),2);
$$;

-- CALL public.add_interest(2.5);
