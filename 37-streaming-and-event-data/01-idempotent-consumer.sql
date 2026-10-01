CREATE TEMP TABLE processed_events (event_id text PRIMARY KEY, processed_at timestamptz NOT NULL DEFAULT now());
INSERT INTO processed_events(event_id) VALUES ('evt-001') ON CONFLICT DO NOTHING;
INSERT INTO processed_events(event_id) VALUES ('evt-001') ON CONFLICT DO NOTHING;
SELECT * FROM processed_events;
-- Extend this pattern with an inbox/outbox design and a business transaction.