-- ============================================================
-- 04 — JSON and JSONB
-- ============================================================
--
-- Definition:
-- JSON stores structured document data. PostgreSQL's JSONB stores a
-- decomposed binary representation that supports efficient querying
-- and indexing.
--
-- Purpose:
-- Learn when semi-structured attributes can complement relational tables.
--
-- Mental model:
-- Stable relational fields -> columns
-- Flexible attributes -> JSONB document
--
-- Expected result:
-- A profile is inserted/upserted, then queried by a JSONB containment
-- condition and by a nested key.
--
-- Design guidance:
-- JSONB is useful for genuinely variable attributes, but frequently
-- queried relational facts usually deserve normal columns.
--
-- Performance:
-- JSONB can be indexed, commonly with GIN, when query patterns justify it.
--
-- Security:
-- Treat JSONB as data, not executable content. Validate application input
-- and avoid storing secrets unnecessarily.
--
-- Production use:
-- Preferences, metadata, event payloads, and flexible configuration.
--
-- Interview:
-- When would you choose JSONB instead of a normal relational column?
-- ============================================================

CREATE TABLE IF NOT EXISTS bank.customer_profiles (
  customer_id BIGINT PRIMARY KEY REFERENCES bank.customers(customer_id),
  preferences JSONB NOT NULL DEFAULT '{}'::jsonb
);

INSERT INTO bank.customer_profiles(customer_id, preferences)
VALUES (1, '{"language":"en","alerts":{"email":true,"sms":false}}')
ON CONFLICT (customer_id) DO UPDATE
SET preferences = EXCLUDED.preferences;

SELECT customer_id
FROM bank.customer_profiles
WHERE preferences @> '{"language":"en"}';

SELECT preferences->'alerts'->>'email' AS email_alert
FROM bank.customer_profiles
WHERE customer_id = 1;
