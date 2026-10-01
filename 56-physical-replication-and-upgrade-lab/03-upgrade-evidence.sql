\set ON_ERROR_STOP on
SELECT current_setting('server_version') AS server_version;
SELECT current_setting('server_encoding') AS server_encoding;
SELECT current_setting('TimeZone') AS timezone;
SELECT extname, extversion FROM pg_extension ORDER BY extname;
SELECT datname, pg_size_pretty(pg_database_size(datname)) AS database_size FROM pg_database ORDER BY datname;