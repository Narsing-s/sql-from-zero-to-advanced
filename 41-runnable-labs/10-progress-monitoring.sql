-- 41.10 — PostgreSQL progress monitoring
-- Run in a disposable database. Progress views are useful for observing
-- long-running maintenance/DDL operations while they are executing.
--
-- PostgreSQL exposes progress views such as pg_stat_progress_vacuum,
-- pg_stat_progress_create_index, pg_stat_progress_analyze and
-- pg_stat_progress_copy. Start an operation in one session and query the
-- corresponding view from another session.

DROP TABLE IF EXISTS progress_monitor_lab;
CREATE TABLE progress_monitor_lab (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  payload text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

INSERT INTO progress_monitor_lab(payload)
SELECT repeat('x', 100)
FROM generate_series(1, 100000);

ANALYZE progress_monitor_lab;

-- Session A examples:
-- VACUUM (VERBOSE, ANALYZE) progress_monitor_lab;
-- CREATE INDEX progress_monitor_lab_payload_idx ON progress_monitor_lab(payload);
-- ANALYZE progress_monitor_lab;

-- Session B: inspect active progress.
SELECT * FROM pg_stat_progress_vacuum
WHERE relid = 'progress_monitor_lab'::regclass;

SELECT * FROM pg_stat_progress_create_index
WHERE relid = 'progress_monitor_lab'::regclass;

SELECT * FROM pg_stat_progress_analyze
WHERE relid = 'progress_monitor_lab'::regclass;

-- COPY progress is visible while COPY is actively running.
SELECT * FROM pg_stat_progress_copy
WHERE relid = 'progress_monitor_lab'::regclass;

-- Correlate progress with the active backend.
SELECT a.pid, a.state, a.wait_event_type, a.wait_event,
       a.query_start, now() - a.query_start AS runtime,
       a.query
FROM pg_stat_activity AS a
WHERE a.datname = current_database()
  AND a.pid <> pg_backend_pid()
ORDER BY a.query_start;

DROP TABLE progress_monitor_lab;
