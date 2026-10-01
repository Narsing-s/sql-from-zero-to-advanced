-- PostgreSQL exposes standardized SQLSTATE error codes; application code should prefer SQLSTATE over parsing message text.
SELECT sqlstate, condition_name FROM (VALUES
  ('23505','unique_violation'),
  ('23503','foreign_key_violation'),
  ('40001','serialization_failure'),
  ('40P01','deadlock_detected'),
  ('57014','query_canceled')
) AS e(sqlstate,condition_name);

-- Review PostgreSQL limits documentation when designing schemas at extreme scale.
SELECT current_setting('max_connections') AS max_connections;
