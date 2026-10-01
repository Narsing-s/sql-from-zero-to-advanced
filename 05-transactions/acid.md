# Transactions and ACID

A transaction groups database operations into one logical unit.

## Why?
A bank transfer may debit A, credit B and record an audit event. If only the debit succeeds, the system is inconsistent. A transaction provides an all-or-nothing boundary.

## ACID
**Atomicity:** all operations commit or none do.

**Consistency:** constraints and business invariants remain valid.

**Isolation:** concurrent transactions are controlled so they do not incorrectly interfere.

**Durability:** committed changes survive failures according to database durability guarantees.

## Example
```sql
BEGIN;
UPDATE bank.accounts SET balance = balance - 500 WHERE account_id = 1 AND balance >= 500;
UPDATE bank.accounts SET balance = balance + 500 WHERE account_id = 2;
COMMIT;
```
In production, application logic must verify required operations before COMMIT.

If the business rule fails, use ROLLBACK.
