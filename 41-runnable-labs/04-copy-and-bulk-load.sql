DROP TABLE IF EXISTS lab_import;
CREATE TABLE lab_import(customer_id bigint,customer_name text,amount numeric(12,2),event_date date);

-- In psql, use a real local file:
-- \\copy lab_import(customer_id,customer_name,amount,event_date) FROM 'data/lab_import.csv' WITH (FORMAT csv,HEADER true);
-- Export:
-- \\copy (SELECT * FROM lab_import ORDER BY customer_id) TO 'data/lab_import_export.csv' WITH (FORMAT csv,HEADER true);
SELECT count(*) AS rows_loaded FROM lab_import;