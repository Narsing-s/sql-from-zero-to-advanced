-- Lock/blocker investigation.
-- This script observes; it does not terminate sessions.

SELECT blocked.pid AS blocked_pid,
       blocked.usename AS blocked_user,
       blocking.pid AS blocking_pid,
       blocking.usename AS blocking_user,
       blocked.wait_event_type,
       blocked.wait_event,
       left(blocked.query, 160) AS blocked_query,
       left(blocking.query, 160) AS blocking_query
FROM pg_stat_activity blocked
JOIN pg_locks blocked_lock
  ON blocked_lock.pid = blocked.pid
 AND NOT blocked_lock.granted
JOIN pg_locks blocking_lock
  ON blocking_lock.locktype = blocked_lock.locktype
 AND blocking_lock.database IS NOT DISTINCT FROM blocked_lock.database
 AND blocking_lock.relation IS NOT DISTINCT FROM blocked_lock.relation
 AND blocking_lock.page IS NOT DISTINCT FROM blocked_lock.page
 AND blocking_lock.tuple IS NOT DISTINCT FROM blocked_lock.tuple
 AND blocking_lock.virtualxid IS NOT DISTINCT FROM blocked_lock.virtualxid
 AND blocking_lock.transactionid IS NOT DISTINCT FROM blocked_lock.transactionid
 AND blocking_lock.classid IS NOT DISTINCT FROM blocked_lock.classid
 AND blocking_lock.objid IS NOT DISTINCT FROM blocked_lock.objid
 AND blocking_lock.objsubid IS NOT DISTINCT FROM blocked_lock.objsubid
 AND blocking_lock.pid <> blocked_lock.pid
JOIN pg_stat_activity blocking
  ON blocking.pid = blocking_lock.pid;

-- Deadlock handling is normally application-level retry of the aborted transaction.
