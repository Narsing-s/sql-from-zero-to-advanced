# 55 — Production Failure and Chaos Labs

This stage turns production failure modes into **safe, repeatable PostgreSQL drills**. Run only against disposable PostgreSQL environments.

## Labs

1. **Connection exhaustion** — distinguish pool starvation, `max_connections` pressure, slow transactions and idle-in-transaction sessions.
2. **Long-running transaction** — observe blocked cleanup, old snapshots and vacuum implications.
3. **Lock contention** — identify the blocker, waiting sessions and safe mitigation.
4. **Deadlock recovery** — reproduce a deadlock in two sessions, capture the evidence and design a retry-safe fix.
5. **WAL pressure** — connect long transactions, replication slots, WAL retention and disk growth.
6. **Replication lag** — measure replay/apply delay and identify the source of lag.
7. **Primary failure rehearsal** — document detection, promotion decision, client redirection and verification.
8. **Replica failure** — determine what service is lost, what remains available and what recovery evidence is required.
9. **Disk-pressure response** — assess database/WAL/filesystem pressure and define safe containment before destructive cleanup.
10. **Recovery verification** — verify data correctness, application connectivity, replication state and monitoring after recovery.
11. **Incident response** — symptoms → evidence → hypothesis → safe mitigation → root cause → permanent fix → validation → prevention.
12. **RCA** — produce a timeline, impact statement, contributing factors, corrective actions and follow-up tests.

## Required evidence

For every drill record:

- PostgreSQL version and environment
- exact reproduction steps
- session IDs / transaction IDs where relevant
- observed SQL and wait events
- safe mitigation
- root cause
- recovery/verification checks
- prevention or permanent fix
- cleanup result

## Safety

Never intentionally exhaust connections, fill disks, corrupt data, promote a real production node or terminate production sessions. Use disposable containers and named test databases.

## Completion rule

A lab is complete only when it is reproducible, has an expected observation, includes a verification step and leaves the environment clean.
