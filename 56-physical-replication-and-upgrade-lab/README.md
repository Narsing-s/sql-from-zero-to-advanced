# 56 — Physical Replication and Major-Upgrade Lab

A remaining production gap is a dedicated physical-replication and major-upgrade exercise.

## Physical replication

Use two disposable PostgreSQL 18 clusters to practice:
- primary/standby roles
- replication connection settings
- replication slots
- WAL receiver/sender inspection
- replay/flush/write positions
- standby read-only behavior
- promotion/failover concepts
- replication lag measurement
- delayed recovery concepts
- clean teardown

## Major upgrade

Practice the decision between:
- `pg_upgrade`
- dump/restore
- logical replication migration

Capture downtime, compatibility checks, extension versions, data checksums and rollback/forward-fix planning.

## Safety
This is a dedicated environment exercise. Never configure these labs against production clusters.

PostgreSQL documents physical replication/recovery as a separate test area from ordinary regression tests, so this stage is intentionally outside the normal single-node CI job.