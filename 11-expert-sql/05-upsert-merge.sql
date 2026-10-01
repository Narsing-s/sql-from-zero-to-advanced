-- ============================================================
-- 05 — UPSERT and MERGE
-- ============================================================
--
-- Definition:
-- UPSERT means insert a row when it does not exist and update it when
-- a uniqueness conflict identifies an existing row. PostgreSQL provides
-- INSERT ... ON CONFLICT for this pattern. MERGE combines source and
-- target matching with conditional INSERT/UPDATE/DELETE actions.
--
-- Purpose:
-- Learn synchronization patterns while keeping conflict handling inside
-- the database statement.
--
-- Mental model:
-- Incoming row -> match key -> conflict? update : insert
--
-- Expected result:
-- The first statement merges preferences into customer 1. MERGE then
-- updates customer 1 if present or inserts it otherwise.
--
-- Important:
-- UPSERT correctness depends on an appropriate UNIQUE/PRIMARY KEY conflict
-- target. Idempotency also depends on choosing the right business key.
--
-- Performance:
-- Upsert-heavy workloads need appropriate unique indexes and should be
-- tested for contention and write amplification.
--
-- Production use:
-- API synchronization, CDC consumers, reference-data loading, and
-- idempotent ingestion.
--
-- Interview:
-- Why is ON CONFLICT safer than "SELECT then INSERT" for concurrent writes?
-- ============================================================

INSERT INTO bank.customer_profiles(customer_id, preferences)
VALUES (1, '{"language":"en"}')
ON CONFLICT (customer_id)
DO UPDATE SET preferences = bank.customer_profiles.preferences || EXCLUDED.preferences;

MERGE INTO bank.customer_profiles AS target
USING (VALUES (1, '{"language":"te"}'::jsonb)) AS source(customer_id, preferences)
ON target.customer_id = source.customer_id
WHEN MATCHED THEN
  UPDATE SET preferences = target.preferences || source.preferences
WHEN NOT MATCHED THEN
  INSERT (customer_id, preferences) VALUES (source.customer_id, source.preferences);
