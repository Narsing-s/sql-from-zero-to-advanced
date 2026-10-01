# PostgreSQL 18 Client and Tooling Checklist

## Client/tooling
- [ ] Identify PostgreSQL client/server versions separately.
- [ ] Use `pg_isready` for connection readiness checks.
- [ ] Use `pg_config` to inspect client installation details.
- [ ] Use `pgbench` for repeatable benchmark workloads.
- [ ] Understand libpq pipeline mode when reducing round-trip overhead.
- [ ] Capture tool version in benchmark evidence.

## Backup verification
- [ ] Produce a base backup.
- [ ] Run `pg_verifybackup`.
- [ ] Record verification output.
- [ ] Test restore separately.
- [ ] For incremental backups, understand `pg_combinebackup` and its dependency chain.

## Integrity
- [ ] Run `pg_amcheck` in an isolated environment.
- [ ] Review failures rather than treating a zero exit code as a complete application-level integrity test.