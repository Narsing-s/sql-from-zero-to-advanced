-- Watermark pattern: load only rows newer than the last successful timestamp.
-- In production, store the watermark in a control table.
WITH watermark AS (
  SELECT TIMESTAMPTZ '2026-01-01 00:00:00+00' AS last_loaded_at
)
SELECT *
FROM bank.transactions t
CROSS JOIN watermark w
WHERE t.updated_at > w.last_loaded_at;
