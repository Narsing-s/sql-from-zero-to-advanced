SELECT table_schema, table_name FROM information_schema.tables WHERE table_schema NOT IN ('pg_catalog','information_schema') ORDER BY 1,2 LIMIT 50;
SELECT table_schema, table_name, column_name, data_type FROM information_schema.columns WHERE table_schema NOT IN ('pg_catalog','information_schema') ORDER BY 1,2,ordinal_position LIMIT 100;
SELECT grantee, table_schema, table_name, privilege_type FROM information_schema.role_table_grants ORDER BY 1,2,3,4 LIMIT 100;
