# 47 — Advanced Concurrency and Isolation

## Topics
- MVCC visibility
- READ COMMITTED versus REPEATABLE READ
- SERIALIZABLE and serialization failures
- deadlock detection and retry strategy
- lost-update prevention
- optimistic locking
- pessimistic locking
- NOWAIT
- SKIP LOCKED
- advisory locks
- deferrable transactions
- predicate locking
- lock monitoring
- isolation test design

## Lab design

Concurrency labs require multiple sessions. Document session A/session B ordering, expected blocking or failure, cleanup, and retry behavior.