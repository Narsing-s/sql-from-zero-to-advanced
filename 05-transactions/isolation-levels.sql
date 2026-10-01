SHOW default_transaction_isolation;
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM beginner.accounts WHERE account_id=1;
COMMIT;