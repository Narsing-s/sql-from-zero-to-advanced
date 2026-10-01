-- ============================================================
-- 03 — Incremental loads and watermarks
-- ============================================================
--
-- Definition:
-- An incremental load processes only data that arrived or changed
-- after a previously successful checkpoint (watermark).
--
-- Purpose:
-- Learn the core idea behind scalable ingestion without rescanning
-- the entire source every run.
--
-- Mental model:
-- Last successful watermark -> source changes -> load -> new watermark
--
-- Important:
-- The banking teaching schema has created_at, not updated_at. Therefore
-- this example demonstrates an append-only watermark using created_at.
-- A real update-aware pipeline needs a reliable updated_at/CDC mechanism.
--
-- Expected result:
-- The query returns transactions created after the stored checkpoint.
--
-- Production considerations:
-- Persist the watermark in a control table, make the load idempotent,
-- handle late-arriving data, and update the checkpoint only after a
-- successful load.
--
-- Performance:
-- A well-designed incremental predicate can reduce source reads greatly
-- compared with full-table reloads.
--
-- Interview:
-- What is a watermark, and when is it insufficient compared with CDC?
-- ============================================================

WITH watermark AS (
  SELECT TIMESTAMPTZ '2026-01-01 00:00:00+00' AS last_loaded_at
)
SELECT t.*
FROM bank.transactions t
CROSS JOIN watermark w
WHERE t.created_at > w.last_loaded_at;
