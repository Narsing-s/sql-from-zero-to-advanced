-- ============================================================
-- 07 — Triggers: automatic reactions to table events
-- ============================================================
--
-- Definition:
-- A trigger automatically invokes a trigger function when a configured
-- INSERT, UPDATE, or DELETE event occurs.
--
-- Purpose:
-- Record account balance changes without requiring every caller to
-- remember to write an audit row.
--
-- Mental model:
-- UPDATE account -> trigger fires -> audit function -> audit row
--
-- Key concepts:
-- OLD = previous row version
-- NEW = new row version
-- AFTER UPDATE = run after the update event
--
-- Expected result:
-- After the trigger is created, an UPDATE that changes a balance adds
-- an entry to public.account_audit.
--
-- Common mistakes:
-- * Trigger logic can surprise application developers.
-- * Poor trigger code can add hidden latency to writes.
--
-- Security:
-- Keep audit tables protected; audit records may contain sensitive data.
--
-- Production use:
-- Auditing, derived-maintenance tasks, and controlled data-integrity
-- workflows are common trigger use cases.
--
-- Interview:
-- What are OLD and NEW in a row-level trigger?
-- ============================================================

CREATE TABLE IF NOT EXISTS public.account_audit(
    audit_id BIGSERIAL PRIMARY KEY,
    account_id BIGINT,
    old_balance NUMERIC(15,2),
    new_balance NUMERIC(15,2),
    changed_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION public.audit_account_balance()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.balance IS DISTINCT FROM NEW.balance THEN
        INSERT INTO public.account_audit(account_id,old_balance,new_balance)
        VALUES(OLD.account_id,OLD.balance,NEW.balance);
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_account_balance_audit ON beginner.accounts;

CREATE TRIGGER trg_account_balance_audit
AFTER UPDATE ON beginner.accounts
FOR EACH ROW
EXECUTE FUNCTION public.audit_account_balance();
