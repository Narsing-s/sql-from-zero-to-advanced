-- 14 — CLUSTER / VACUUM FULL progress monitoring
-- PostgreSQL 18
-- Run in a disposable database. CLUSTER and VACUUM FULL require an exclusive
-- table lock and can be disruptive on large tables.

DROP TABLE IF EXISTS lab_cluster_progress;
CREATE TABLE lab_cluster_progress (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  payload text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT clock_timestamp()
);

INSERT INTO lab_cluster_progress (payload)
SELECT repeat('x', 200)
FROM generate_series(1, 100000);

CREATE INDEX lab_cluster_progress_created_idx
  ON lab_cluster_progress (created_at);

-- Start this in session A:
--   CLUSTER lab_cluster_progress USING lab_cluster_progress_created_idx;
--
-- While it is running, execute the following from session B.
SELECT
  p.pid,
  p.datname,
  p.relid::regclass AS relation_name,
  p.command,
  p.phase,
  p.heap_tuples_scanned,
  p.heap_tuples_written,
  p.heap_blks_total,
  p.heap_blks_scanned,
  p.index_rebuild_count,
  a.state,
  a.wait_event_type,
  a.wait_event,
  a.query_start
FROM pg_stat_progress_cluster AS p
LEFT JOIN pg_stat_activity AS a ON a.pid = p.pid
ORDER BY p.pid;

-- The same view reports VACUUM FULL progress:
--   VACUUM FULL lab_cluster_progress;
--
-- Verify the table/index after the operation.
SELECT
  c.relname,
  c.relkind,
  pg_size_pretty(pg_relation_size(c.oid)) AS relation_size
FROM pg_class AS c
WHERE c.relname IN ('lab_cluster_progress', 'lab_cluster_progress_created_idx');

-- Cleanup.
DROP TABLE lab_cluster_progress;
