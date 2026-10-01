# Logical Replication Restrictions

Logical replication does not replicate database schema/DDL automatically, and sequence state is not replicated as sequence state.

## Production checklist
- Apply compatible subscriber schema changes deliberately.
- Treat DDL migration as a separate deployment workflow.
- Monitor pg_stat_subscription.
- Monitor replication slots and retained WAL.
- Verify identity/sequence behavior after synchronization.
- Test conflicts and apply-worker failures.
- Document row filters and column lists.
- Test generated-column behavior on PostgreSQL 18.
- Plan extension/version compatibility on both sides.
- Do not treat logical replication as a backup.

See the migration, upgrade and logical replication stages for executable drills.