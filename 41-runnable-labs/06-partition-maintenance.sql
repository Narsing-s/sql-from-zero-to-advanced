DROP TABLE IF EXISTS lab_events CASCADE;
CREATE TABLE lab_events(event_id bigint GENERATED ALWAYS AS IDENTITY,event_date date NOT NULL,payload jsonb NOT NULL) PARTITION BY RANGE(event_date);
CREATE TABLE lab_events_2026_10 PARTITION OF lab_events FOR VALUES FROM ('2026-10-01') TO ('2026-11-01');
CREATE TABLE lab_events_default PARTITION OF lab_events DEFAULT;
INSERT INTO lab_events(event_date,payload) VALUES ('2026-10-02','{"type":"payment"}'),('2026-12-01','{"type":"future"}');
EXPLAIN (COSTS OFF) SELECT * FROM lab_events WHERE event_date >= DATE '2026-10-01' AND event_date < DATE '2026-11-01';
-- Lifecycle: ALTER TABLE lab_events DETACH PARTITION lab_events_2026_10;