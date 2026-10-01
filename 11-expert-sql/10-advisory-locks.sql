-- Advisory locks coordinate application-level work.
-- They are useful when two workers must not perform the same logical operation.
SELECT pg_advisory_lock(10001);

-- Do protected work here.

SELECT pg_advisory_unlock(10001);

-- Practice: use a lock key derived from an account/customer identifier.
-- Always design timeout/error handling around locks.
