SELECT current_database() AS database_name,current_user AS current_user,version() AS postgres_version;
SELECT current_setting('server_version_num') AS server_version_num;
SELECT n.nspname AS schema_name,c.relname AS object_name,c.relkind
FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
WHERE n.nspname NOT IN ('pg_catalog','information_schema') ORDER BY 1,2;
SELECT extname,extversion FROM pg_extension ORDER BY extname;