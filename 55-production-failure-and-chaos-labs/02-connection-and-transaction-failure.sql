-- Safe failure-analysis queries.
-- Run against a disposable/test PostgreSQL database.

SELECT pid, usename, state, wait_event_type, wait_event,
       xact_start, query_start, left(query, 120) AS query
FROM pg_stat_activity
ORDER BY xact_start NULLS LAST;

SELECT pid,
       now() - xact_start AS transaction_age,
       state,
       left(query, 120) AS query
FROM pg_stat_activity
WHERE xact_start IS NOT NULL
ORDER BY xact_start;

SELECT datname, numbackends, xact_commit, xact_rollback
FROM pg_stat_database
ORDER BY numbackends DESC;

-- Use this evidence before deciding whether a session is safe to terminate.
