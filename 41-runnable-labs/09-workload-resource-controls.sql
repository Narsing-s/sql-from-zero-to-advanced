-- 41.9 — Workload/resource controls
-- Disposable session lab. Settings are session-local unless noted.
-- Do not use arbitrary production values from this exercise.

SHOW work_mem;
SHOW maintenance_work_mem;
SHOW temp_file_limit;
SHOW statement_timeout;
SHOW lock_timeout;
SHOW idle_in_transaction_session_timeout;

SELECT name, setting, unit, context, source
FROM pg_settings
WHERE name IN (
  'work_mem',
  'maintenance_work_mem',
  'temp_file_limit',
  'statement_timeout',
  'lock_timeout',
  'idle_in_transaction_session_timeout'
)
ORDER BY name;

-- Session-local workload guardrails.
SET LOCAL work_mem = '16MB';
SET LOCAL statement_timeout = '5s';
SET LOCAL lock_timeout = '2s';
SET LOCAL idle_in_transaction_session_timeout = '30s';

-- Observe active sessions and wait state.
SELECT pid, usename, state, wait_event_type, wait_event,
       query_start, now() - query_start AS runtime, query
FROM pg_stat_activity
WHERE pid <> pg_backend_pid()
ORDER BY query_start NULLS LAST;

-- Temp spill and sort/hash behavior should be investigated with
-- EXPLAIN (ANALYZE, BUFFERS), not by blindly increasing work_mem.
-- Example:
-- EXPLAIN (ANALYZE, BUFFERS)
-- SELECT * FROM generate_series(1,100000) g ORDER BY g DESC;

RESET work_mem;
RESET statement_timeout;
RESET lock_timeout;
RESET idle_in_transaction_session_timeout;
