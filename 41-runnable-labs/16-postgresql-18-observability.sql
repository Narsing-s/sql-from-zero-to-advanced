-- 16 — PostgreSQL 18 observability additions
-- PostgreSQL 18
-- Covers recovery prefetch, WAL archiving, per-backend I/O/WAL, and new
-- maintenance timing statistics. Read-only inspection except SET LOCAL.

SELECT version();

-- 1. Recovery prefetch telemetry. On a primary this may be mostly idle;
-- meaningful values are normally observed during recovery/replay.
SELECT * FROM pg_stat_recovery_prefetch;

-- 2. WAL archiver health.
SELECT
  archived_count,
  failed_count,
  last_archived_wal,
  last_archived_time,
  last_failed_wal,
  last_failed_time,
  stats_reset
FROM pg_stat_archiver;

-- 3. PostgreSQL 18 cluster-wide I/O, including WAL rows.
SELECT
  backend_type,
  object,
  context,
  reads,
  read_bytes,
  writes,
  write_bytes,
  extends,
  extend_bytes,
  fsyncs,
  fsync_time
FROM pg_stat_io
ORDER BY backend_type, object, context;

-- 4. I/O for the current backend.
SELECT *
FROM pg_stat_get_backend_io(pg_backend_pid());

-- 5. WAL statistics for the current backend.
SELECT *
FROM pg_stat_get_backend_wal(pg_backend_pid());

-- 6. PostgreSQL 18 maintenance timing additions.
SELECT
  relname,
  n_live_tup,
  n_dead_tup,
  total_vacuum_time,
  total_autovacuum_time,
  total_analyze_time,
  total_autoanalyze_time
FROM pg_stat_all_tables
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY GREATEST(
  total_vacuum_time,
  total_autovacuum_time,
  total_analyze_time,
  total_autoanalyze_time
) DESC
LIMIT 20;

-- 7. Check whether optional I/O timing is enabled.
SELECT name, setting, unit, short_desc
FROM pg_settings
WHERE name IN ('track_io_timing', 'track_wal_io_timing', 'track_cost_delay_timing');

-- 8. Lock-failure logging is configured at the server level.
-- Inspect it; do not enable it automatically in a learning script.
SELECT name, setting, context, short_desc
FROM pg_settings
WHERE name = 'log_lock_failures';

-- Operational note:
-- pg_stat_reset_shared(...) is intentionally not executed here because it
-- changes cluster-wide counters and should be an explicit operator action.