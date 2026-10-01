-- UPSERT inserts or updates atomically when a conflict occurs.
INSERT INTO bank.customer_profiles(customer_id, preferences)
VALUES (1, '{"language":"en"}')
ON CONFLICT (customer_id)
DO UPDATE SET preferences = bank.customer_profiles.preferences || EXCLUDED.preferences;

-- MERGE is useful when synchronizing a source with a target.
-- Syntax varies by PostgreSQL version; verify your installed version before production use.
MERGE INTO bank.customer_profiles AS target
USING (VALUES (1, '{"language":"te"}'::jsonb)) AS source(customer_id, preferences)
ON target.customer_id = source.customer_id
WHEN MATCHED THEN
  UPDATE SET preferences = target.preferences || source.preferences
WHEN NOT MATCHED THEN
  INSERT (customer_id, preferences) VALUES (source.customer_id, source.preferences);
