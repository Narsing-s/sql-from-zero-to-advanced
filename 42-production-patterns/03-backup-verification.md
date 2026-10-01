# Backup Verification

A backup that cannot be restored is not a recovery strategy.

Drill:
1. create a backup
2. record metadata/checksum where available
3. restore into an isolated instance
4. verify schema and representative row counts
5. run application integrity checks
6. run representative queries
7. record restore duration
8. compare recoverable point with RPO
9. destroy the temporary restore environment

Repeat regularly and treat restore testing as an operational control.