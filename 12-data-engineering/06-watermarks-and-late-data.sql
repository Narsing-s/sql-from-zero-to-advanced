-- Incremental-load watermark pattern.
-- A watermark represents the last successfully processed source position/time.

DROP TABLE IF EXISTS source_events;
CREATE TABLE source_events (
    event_id BIGSERIAL PRIMARY KEY,
    updated_at TIMESTAMPTZ NOT NULL,
    payload JSONB NOT NULL
);

-- Example extraction window.
-- In production, persist the previous successful watermark separately.
-- Use a half-open interval to avoid duplicate boundary processing.

-- SELECT *
-- FROM source_events
-- WHERE updated_at >= :previous_watermark
--   AND updated_at <  :new_watermark
-- ORDER BY updated_at, event_id;

-- Late-arriving data means a row can arrive after the expected watermark.
-- A production pipeline commonly combines a replay/lookback window with
-- idempotent merge logic rather than assuming timestamps are perfect.
