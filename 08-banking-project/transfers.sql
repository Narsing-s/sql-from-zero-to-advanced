-- ============================================================
-- Banking project — transfer transaction
-- ============================================================
--
-- Definition:
-- A transfer is a business operation that must keep the debit, credit,
-- and transaction records consistent.
--
-- Purpose:
-- Demonstrate transaction boundaries around a transfer-like workflow.
--
-- Mental model:
-- BEGIN -> validate/debit -> credit -> record -> COMMIT
-- Any failure -> ROLLBACK
--
-- Expected result:
-- Account 1 is reduced by 1,000, account 2 is increased by 1,000,
-- and two transaction records are inserted if the transaction commits.
--
-- Important production gap:
-- This teaching script should not be treated as production banking code.
-- It does not fully validate affected rows, account ownership/status,
-- concurrent access, idempotency, or all failure paths.
--
-- Concurrency:
-- Production transfer logic should use an appropriate locking/serialization
-- strategy so concurrent transfers cannot violate account invariants.
--
-- Security:
-- Authorization must be checked before money movement; do not trust a
-- caller-provided account ID without validating ownership/permissions.
--
-- Practice:
-- Design a rollback path for an insufficient-funds debit.
--
-- Interview:
-- Which steps of a transfer must be inside the same transaction, and why?
-- ============================================================

BEGIN;

UPDATE bank.accounts
SET balance=balance-1000
WHERE account_id=1 AND balance>=1000;

UPDATE bank.accounts
SET balance=balance+1000
WHERE account_id=2;

INSERT INTO bank.transactions(account_id,transaction_type,amount,reference_code,description)
VALUES
(1,'TRANSFER',1000,'TXN-TRANSFER-001','Transfer to account 2'),
(2,'TRANSFER',1000,'TXN-TRANSFER-002','Transfer from account 1');

COMMIT;

-- For production: row locks, affected-row validation, idempotency
-- and explicit failure handling are required.
