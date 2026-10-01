-- Deterministic duplicate detection and canonical-row selection.

DROP TABLE IF EXISTS incoming_events;

CREATE TABLE incoming_events (
    event_id BIGSERIAL PRIMARY KEY,
    business_key TEXT NOT NULL,
    event_time TIMESTAMPTZ NOT NULL,
    received_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    payload JSONB NOT NULL
);

INSERT INTO incoming_events (business_key, event_time, payload)
VALUES
 ('ORDER-1', '2026-01-01 10:00:00+00', '{"status":"created"}'),
 ('ORDER-1', '2026-01-01 10:05:00+00', '{"status":"paid"}'),
 ('ORDER-2', '2026-01-01 11:00:00+00', '{"status":"created"}');

-- Inspect duplicate business keys.
SELECT business_key, COUNT(*) AS row_count
FROM incoming_events
GROUP BY business_key
HAVING COUNT(*) > 1;

-- Keep the newest event per business key.
SELECT DISTINCT ON (business_key)
       business_key, event_time, received_at, payload
FROM incoming_events
ORDER BY business_key, event_time DESC, event_id DESC;
