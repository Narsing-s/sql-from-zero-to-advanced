\set ON_ERROR_STOP on
SELECT version();
SELECT current_setting('server_version_num') AS server_version_num;
SELECT current_setting('shared_preload_libraries') AS shared_preload_libraries;
SELECT current_setting('track_io_timing') AS track_io_timing;
SELECT current_setting('jit') AS jit;
SELECT current_setting('max_connections') AS max_connections;
SELECT pg_size_pretty(pg_database_size(current_database())) AS current_database_size;

-- Run pgbench separately from the SQL session and store its command/version/output with the benchmark evidence.
SELECT now() AS evidence_captured_at;