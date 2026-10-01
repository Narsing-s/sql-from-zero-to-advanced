-- ============================================================
-- Transactions: making related changes atomic
-- ============================================================
--
-- Definition:
-- A transaction groups database operations into one logical unit.
-- COMMIT makes the unit permanent; ROLLBACK discards it.
--
-- Purpose:
-- Demonstrate the basic shape of a transfer-like operation.
--
-- Mental model:
-- BEGIN -> debit -> credit -> validate -> COMMIT
-- Failure -> ROLLBACK
--
-- Syntax:
-- BEGIN;
-- statement 1;
-- statement 2;
-- COMMIT; -- or ROLLBACK;
--
-- Expected result:
-- Account 1 is debited only when it has at least 1,000, and account 2
-- is credited before the transaction commits.
--
-- Important limitation:
-- This teaching example does not fully validate that the debit affected
-- a row before crediting the receiver. Production transfer logic must
-- check affected rows, account state, authorization, and concurrency.
--
-- Concurrency:
-- Financial transfers normally need row-level locking or an equivalent
-- concurrency strategy so simultaneous updates cannot violate invariants.
--
-- Production use:
-- Transfers, order placement, inventory updates, and payment workflows
-- often require atomic multi-step transactions.
--
-- Interview:
-- Why should a money transfer be executed in one transaction?
-- ============================================================

BEGIN;

UPDATE beginner.accounts
SET balance=balance-1000
WHERE account_id=1 AND balance>=1000;

UPDATE beginner.accounts
SET balance=balance+1000
WHERE account_id=2;

COMMIT;

-- Production implementation must validate affected rows and business rules.
