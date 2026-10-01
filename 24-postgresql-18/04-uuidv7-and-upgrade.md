# UUIDv7 and major-version upgrade

uuidv7() creates timestamp-ordered UUID values. Compare index locality against random UUIDs for your workload.

Major-version upgrade planning should include a rehearsal, compatibility tests, plan comparison, downtime measurement and a rollback/forward-recovery procedure. Document the chosen path: dump/restore, pg_upgrade or logical replication.
