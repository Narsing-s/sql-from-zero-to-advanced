\set ON_ERROR_STOP on
SELECT current_setting('server_version_num') AS server_version_num;
DO $$ DECLARE v integer := current_setting('server_version_num')::integer; BEGIN IF v < 180000 THEN RAISE NOTICE 'PostgreSQL 18-specific checks require PostgreSQL 18+'; ELSE RAISE NOTICE 'PostgreSQL 18+ detected'; END IF; END $$;
SELECT extname,extversion FROM pg_extension ORDER BY extname;