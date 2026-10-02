-- 15 — Replication origin progress tracking
-- PostgreSQL 18
-- Demonstrates the catalog/view/function surface used by logical replication
-- implementations. Run in a disposable PostgreSQL cluster.
--
-- A replication origin is not a replication slot. It records replay progress
-- for a named remote source and helps a logical apply process resume safely.

SELECT version();

-- Create a disposable origin.
SELECT pg_replication_origin_create('sql101_demo_origin');

-- Inspect the cluster-wide origin catalog.
SELECT roident, roname
FROM pg_replication_origin
WHERE roname = 'sql101_demo_origin';

-- Inspect replay progress. A newly-created origin has no meaningful replay
-- position until an apply process records progress.
SELECT
  local_id,
  external_id,
  remote_lsn,
  local_lsn,
  local_commit_time
FROM pg_replication_origin_status
WHERE external_id = 'sql101_demo_origin';

-- Bind this session to the origin so an apply implementation can associate
-- transactions with it.
SELECT pg_replication_origin_session_setup('sql101_demo_origin');

SELECT pg_replication_origin_session_is_setup();

-- Before any source transaction is replayed, the progress function returns
-- the origin's current position.
SELECT pg_replication_origin_session_progress(false);

-- Reset the session selection.
SELECT pg_replication_origin_session_reset();

-- Direct lookup works even when the origin is not selected.
SELECT
  pg_replication_origin_oid('sql101_demo_origin') AS origin_oid,
  pg_replication_origin_progress('sql101_demo_origin', false) AS replay_lsn;

-- Cleanup.
SELECT pg_replication_origin_drop('sql101_demo_origin');

-- Verify cleanup.
SELECT *
FROM pg_replication_origin
WHERE roname = 'sql101_demo_origin';
