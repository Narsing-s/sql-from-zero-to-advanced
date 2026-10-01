BEGIN;
UPDATE bank.accounts SET balance=balance-1000 WHERE account_id=1 AND balance>=1000;
UPDATE bank.accounts SET balance=balance+1000 WHERE account_id=2;
INSERT INTO bank.transactions(account_id,transaction_type,amount,reference_code,description) VALUES(1,'TRANSFER',1000,'TXN-TRANSFER-001','Transfer to account 2'),(2,'TRANSFER',1000,'TXN-TRANSFER-002','Transfer from account 1');
COMMIT;
-- For production: row locks, affected-row validation, idempotency and explicit failure handling.