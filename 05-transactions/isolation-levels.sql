-- ============================================================
-- Isolation levels: controlling concurrent transaction visibility
-- ============================================================
--
-- Definition:
-- Transaction isolation controls how one transaction can observe
-- changes made by concurrent transactions.
--
-- Purpose:
-- Learn how PostgreSQL reports and sets the isolation level for a
-- transaction.
--
-- Mental model:
-- Concurrent transactions -> isolation rules -> visible data
--
-- Key idea:
-- REPEATABLE READ gives a transaction a stable snapshot for its reads,
-- subject to PostgreSQL's documented serialization behavior.
--
-- Expected result:
-- SHOW displays the session default. The transaction then explicitly
-- uses REPEATABLE READ for its SELECT.
--
-- Practice:
-- Open two database sessions and experiment with concurrent updates.
-- Observe what each isolation level allows.
--
-- Common mistake:
-- Isolation level is not the same thing as a lock. Isolation defines
-- visibility/concurrency semantics; locks coordinate conflicting work.
--
-- Production use:
-- Choose isolation based on business correctness requirements and
-- workload characteristics, not simply because "higher is better."
--
-- Interview:
-- What anomalies are associated with READ COMMITTED and REPEATABLE READ?
-- ============================================================

SHOW default_transaction_isolation;

BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM beginner.accounts WHERE account_id=1;
COMMIT;
