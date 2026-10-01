# Database Incident Runbook

## Connection exhaustion

Check active sessions, application pool size, idle sessions and long-running transactions before increasing limits.

## Slow query

1. Capture the exact query and parameters.
2. Check duration and frequency.
3. Inspect EXPLAIN/EXPLAIN ANALYZE in a safe environment.
4. Check statistics and indexes.
5. Check blocking and I/O pressure.
6. Apply one controlled change.
7. Measure again.

## Blocking

Identify the blocked session and blocking session. Inspect transaction age and SQL before deciding whether cancellation is safe.

## Deadlock

Collect the involved statements and transaction order. Fix inconsistent lock ordering where possible and make retry behavior explicit.

## Replication lag

Check whether lag is caused by workload, WAL retention, network/storage pressure or a replica bottleneck. Do not treat a replica as healthy solely because it is reachable.

## RCA template

- Incident:
- Customer/business impact:
- Start/end:
- Detection:
- Evidence:
- Root cause:
- Immediate mitigation:
- Permanent fix:
- Validation:
- Preventive action:
