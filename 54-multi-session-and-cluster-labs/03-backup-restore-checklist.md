# Backup/Restore Harness Checklist

1. Start a disposable PostgreSQL 18.6 container.
2. Create deterministic fixture data.
3. Run pg_dump in custom format.
4. Record artifact checksum and size.
5. Drop the test database.
6. Recreate an empty database.
7. Run pg_restore.
8. Compare schema and row-count/content assertions.
9. Record dump and restore duration.
10. Remove the disposable environment.

Restore must be validated by SQL assertions, not only by a successful pg_restore exit code.