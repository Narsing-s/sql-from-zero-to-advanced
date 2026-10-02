-- Concurrent index maintenance checklist/examples.
-- Always validate the exact operation and workload on a staging copy first.

CREATE TABLE IF NOT EXISTS index_maintenance_demo (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  value text NOT NULL
);

CREATE INDEX IF NOT EXISTS index_maintenance_demo_value_idx
  ON index_maintenance_demo(value);

-- CREATE INDEX CONCURRENTLY and REINDEX CONCURRENTLY reduce blocking
-- compared with ordinary operations, but still have operational trade-offs.
-- These statements are intentionally commented so the lesson cannot
-- unexpectedly alter a learner's database:
--
-- CREATE INDEX CONCURRENTLY idx_demo_value2
--   ON index_maintenance_demo(value);
--
-- REINDEX INDEX CONCURRENTLY index_maintenance_demo_value_idx;

SELECT schemaname, relname, indexrelname, idx_scan, idx_tup_read, idx_tup_fetch
FROM pg_stat_user_indexes
WHERE relname = 'index_maintenance_demo';
