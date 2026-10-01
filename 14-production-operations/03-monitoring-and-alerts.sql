-- Production-oriented monitoring examples.
-- Run with an appropriately privileged PostgreSQL account.
-- These queries are observational; review output before taking action.

-- Active sessions
SELECT pid, usename, state, application_name,
       now() - query_start AS query_age,
       wait_event_type, wait_event,
       LEFT(query, 200) AS query_text
FROM pg_stat_activity
WHERE state <> 'idle'
ORDER BY query_age DESC;

-- Long-running transactions
SELECT pid, usename,
       now() - xact_start AS transaction_age,
       state,
       LEFT(query, 200) AS query_text
FROM pg_stat_activity
WHERE xact_start IS NOT NULL
ORDER BY xact_start;

-- Database sizes
SELECT datname,
       pg_size_pretty(pg_database_size(datname)) AS database_size
FROM pg_database
ORDER BY pg_database_size(datname) DESC;

-- Replication status on a primary
SELECT application_name, client_addr, state,
       write_lag, flush_lag, replay_lag
FROM pg_stat_replication;

-- Important: an empty pg_stat_replication result can be valid when
-- the server has no configured physical standbys.
