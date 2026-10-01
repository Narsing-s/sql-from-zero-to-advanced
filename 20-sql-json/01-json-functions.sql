WITH payload AS (SELECT '{"customer":{"id":101,"name":"Narsing"},"active":true}'::jsonb AS doc)
SELECT jsonb_path_exists(doc, '$.customer.id') AS has_customer_id, jsonb_path_query_first(doc, '$.customer.name') AS customer_name, jsonb_path_query_first(doc, '$.customer.id') #>> '{}' AS customer_id FROM payload;
