-- PostgreSQL 18+
WITH payload AS (SELECT '[{"id":1,"name":"A","amount":10.5},{"id":2,"name":"B","amount":20.0}]'::jsonb AS doc)
SELECT jt.* FROM payload, JSON_TABLE(payload.doc, '$[*]' COLUMNS (id integer PATH '$.id', name text PATH '$.name', amount numeric PATH '$.amount')) AS jt;
