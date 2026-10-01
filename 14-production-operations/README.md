# 14 — Production Database Operations

This module connects SQL knowledge to day-2 production support.

## Topics

1. Backup and restore strategy
2. Point-in-time recovery (PITR) concepts
3. Recovery Point Objective (RPO) and Recovery Time Objective (RTO)
4. Connection exhaustion
5. Long-running and idle-in-transaction sessions
6. Blocking and deadlock investigation
7. Replication lag
8. Slow-query investigation
9. Capacity planning
10. Monitoring, alerting and incident response
11. RCA and preventive actions
12. Safe production change management

## Production troubleshooting loop

Symptom → Scope → Evidence → Hypothesis → Safe mitigation → Root cause → Permanent fix → Validation → Prevention

## Rule

Do not change production configuration or terminate sessions blindly. Capture evidence first, understand transaction impact, and use an approved change process.

See the runnable examples in this directory and the related material in `05-transactions/`, `06-performance/`, `07-security/`, and `09-real-world-scenarios/`.
