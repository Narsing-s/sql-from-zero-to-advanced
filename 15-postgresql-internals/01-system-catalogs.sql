-- Read-only system catalog discovery
SELECT current_database(), version();
SELECT schemaname, tablename FROM pg_catalog.pg_tables WHERE schemaname NOT LIKE 'pg_%' ORDER BY 1,2 LIMIT 25;
SELECT n.nspname AS schema_name, c.relname AS relation_name, c.relkind FROM pg_catalog.pg_class c JOIN pg_catalog.pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname NOT IN ('pg_catalog','information_schema') ORDER BY 1,2 LIMIT 50;
SELECT p.oid, n.nspname, p.proname, pg_get_function_identity_arguments(p.oid) FROM pg_catalog.pg_proc p JOIN pg_catalog.pg_namespace n ON n.oid=p.pronamespace WHERE n.nspname NOT IN ('pg_catalog','information_schema') ORDER BY 2,3 LIMIT 50;
