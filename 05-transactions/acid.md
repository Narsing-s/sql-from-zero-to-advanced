# Transactions and ACID

Atomicity: all operations succeed or none do.
Consistency: rules remain valid.
Isolation: concurrent transactions do not incorrectly interfere.
Durability: committed data survives normal failures.

Bank transfer: begin → validate → debit → credit → record → commit. Failure means rollback.