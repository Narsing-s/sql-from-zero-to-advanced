-- 41.12 — Base-backup progress monitoring
-- PostgreSQL 18+. This is an observation lab: run a base backup from a
-- second session/tool while querying the progress view from this session.
--
-- In a real environment use pg_basebackup with an appropriate replication
-- role. Do not run backup commands against production from a learning shell.

-- Observe currently running base backups.
SELECT pid,
       phase,
       backup_total,
       backup_streamed,
       tablespaces_total,
       tablespaces_streamed,
       started_at,
       now() - started_at AS elapsed
FROM pg_stat_progress_basebackup
ORDER BY started_at;

-- Correlate with the backend responsible for the backup.
SELECT p.pid,
       p.phase,
       p.backup_total,
       p.backup_streamed,
       a.usename,
       a.client_addr,
       a.state,
       a.query_start
FROM pg_stat_progress_basebackup AS p
LEFT JOIN pg_stat_activity AS a ON a.pid = p.pid
ORDER BY p.pid;

-- Production verification questions:
-- * Is backup progress advancing?
-- * How long has the current phase lasted?
-- * Is the backup consuming expected network/storage resources?
-- * Does monitoring alert when a backup is stuck?
