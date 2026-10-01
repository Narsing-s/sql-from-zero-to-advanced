SELECT pid, usename, state, wait_event_type, wait_event, query_start, query FROM pg_stat_activity WHERE pid <> pg_backend_pid() ORDER BY query_start;
SELECT blocked.pid AS blocked_pid, blocker.pid AS blocker_pid, blocked.query AS blocked_query, blocker.query AS blocker_query FROM pg_stat_activity blocked JOIN pg_stat_activity blocker ON blocker.pid = ANY(pg_blocking_pids(blocked.pid));
SELECT locktype, mode, granted, count(*) FROM pg_locks GROUP BY locktype, mode, granted ORDER BY locktype, mode;
