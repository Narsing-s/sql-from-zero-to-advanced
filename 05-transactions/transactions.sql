BEGIN;
UPDATE beginner.accounts SET balance=balance-1000 WHERE account_id=1 AND balance>=1000;
UPDATE beginner.accounts SET balance=balance+1000 WHERE account_id=2;
COMMIT;
-- Production implementation must validate affected rows and business rules.