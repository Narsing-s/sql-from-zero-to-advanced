# PostgreSQL Major Upgrade Checklist

1. Inventory extensions and versions.
2. Capture PostgreSQL configuration.
3. Validate application compatibility.
4. Record data size and downtime budget.
5. Choose `pg_upgrade`, dump/restore or logical replication.
6. Rehearse the selected path.
7. Validate row counts, constraints, indexes and application smoke tests.
8. Measure downtime.
9. Define rollback/forward-fix procedure.
10. Archive evidence from the rehearsal.

PostgreSQL 18 documentation states that migration from a previous major release requires a migration method such as dump/restore, `pg_upgrade` or logical replication.