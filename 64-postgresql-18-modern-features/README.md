# Stage 64 — PostgreSQL 18 Modern Features & Operational Scenarios

This stage audits PostgreSQL 18 release-level capabilities that were not yet represented as a dedicated theory/scenario bank.

## Coverage
- Asynchronous I/O (AIO)
- B-tree skip scan
- uuidv7()
- virtual generated columns
- OLD/NEW RETURNING
- temporal constraints
- OAuth authentication
- pg_upgrade optimizer-statistics retention
- mixed-version compatibility
- feature rollout and observability
- 35 theory Q&As
- 30 production scenarios

PostgreSQL 18.6 documentation and release notes are the version reference for this stage. citeturn0search1turn0search11

## Files
- `01-modern-features-theory-qa.md`
- `02-modern-features-scenarios-qa.md`

## Principle
Do not treat a version feature as automatically beneficial. Understand its semantics, benchmark it under representative workload, monitor it, and define a compatibility/rollback strategy.
