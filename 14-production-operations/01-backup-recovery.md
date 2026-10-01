# Backup, Recovery, RPO and RTO

## Backup types

- Logical backup: SQL/object-level export.
- Physical backup: database storage/base backup.
- WAL archiving: enables point-in-time recovery when configured correctly.

## RPO

How much committed data the business can afford to lose after a failure.

## RTO

How quickly the service must be restored.

## Recovery drill

A backup is not considered reliable merely because it completed successfully. Restore it into a controlled environment and verify:

1. database starts;
2. expected objects exist;
3. row counts/checksums are reasonable;
4. application connectivity works;
5. critical queries work;
6. the recovery timestamp is documented.

## Production questions

- Where are backups stored?
- How long are they retained?
- Are backups encrypted?
- Who can restore them?
- When was the last restore test?
- What happens if the primary database is unavailable?
