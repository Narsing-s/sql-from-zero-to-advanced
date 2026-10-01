# Integrity and Backup Lab

This lab turns PostgreSQL 18 command-line tools into a reproducible operational exercise.

## Fixture
Create a disposable database and load deterministic tables. Record the PostgreSQL server version, client utility versions, database size, checksum setting, backup format, and backup manifest location.

## Integrity check
Run pg_amcheck against the disposable database. Review exit status and captured output. pg_amcheck checks supported relation structures using the server-side amcheck functionality; it is not a substitute for application-level correctness testing.

## Backup verification
1. Create a base backup with pg_basebackup.
2. Preserve the generated backup_manifest.
3. Run pg_verifybackup against the backup.
4. Perform a clean test restore.
5. Compare deterministic row counts/checksums.
6. Record elapsed time and storage used.

A successful pg_verifybackup run does not prove that a restored database is fully usable; PostgreSQL documentation recommends test restores as an additional verification step.

## Incremental-backup exercise
When incremental backups are available:
1. Record the full-backup dependency chain.
2. Reconstruct a synthetic full backup with pg_combinebackup.
3. Verify the reconstructed backup.
4. Test restore.
5. Keep dependency metadata with the backup evidence.

## Evidence
Store tool versions, commands, exit status, timings and restore-validation results. Never run this exercise against a production data directory.