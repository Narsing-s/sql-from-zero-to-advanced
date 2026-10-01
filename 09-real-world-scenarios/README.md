# 09 — Real-World SQL Scenarios

## Goal
Practice troubleshooting failures that occur in production systems.

## Scenarios
- slow query
- duplicate data
- deadlock
- connection exhaustion
- incorrect balance
- database outage

## Incident method
Symptoms → Scope → Evidence → Root Cause → Fix → Validation → Prevention

## Evidence
- exact query
- execution plan
- timing and row counts
- locks and blocking
- active sessions
- database errors
- recent changes
- CPU, memory and I/O pressure

## Rule
Do not jump directly to a fix. First prove the failure mode.

## Practice
For every scenario document:
1. What happened?
2. Why did it happen?
3. How was it detected?
4. How was it fixed?
5. How will recurrence be prevented?
