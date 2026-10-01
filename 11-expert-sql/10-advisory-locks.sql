-- ============================================================
-- 10 — Advisory locks
-- ============================================================
--
-- Definition:
-- An advisory lock is an application-defined PostgreSQL lock identified
-- by a key. PostgreSQL does not automatically know the business meaning
-- of that key; cooperating processes must use the same convention.
--
-- Purpose:
-- Coordinate work such as "only one worker processes this logical job."
--
-- Mental model:
-- Logical resource key -> acquire lock -> protected work -> release lock
--
-- Expected result:
-- The session acquires advisory lock 10001, performs the placeholder
-- work, then releases the lock.
--
-- Important:
-- Advisory locks are cooperative. A process that ignores the convention
-- can still perform the protected operation.
--
-- Concurrency:
-- Use a stable lock-key design and explicit timeout/error handling.
-- Prefer pg_try_advisory_lock when waiting indefinitely is undesirable.
--
-- Production use:
-- Prevent duplicate scheduled work, coordinate singleton jobs, or
-- serialize application-defined operations.
--
-- Interview:
-- How are advisory locks different from row-level locks?
-- ============================================================

SELECT pg_advisory_lock(10001);

-- Do protected work here.

SELECT pg_advisory_unlock(10001);

-- Practice: use a lock key derived from an account/customer identifier.
-- Always design timeout/error handling around locks.
