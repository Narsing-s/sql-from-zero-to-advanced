DROP TABLE IF EXISTS lab_target;
DROP TABLE IF EXISTS lab_source;
CREATE TABLE lab_target(id bigint PRIMARY KEY,value text);
CREATE TABLE lab_source(id bigint PRIMARY KEY,value text);
INSERT INTO lab_target VALUES (1,'old'),(2,'keep');
INSERT INTO lab_source VALUES (1,'new'),(3,'inserted');

MERGE INTO lab_target AS t USING lab_source AS s ON s.id=t.id
WHEN MATCHED THEN UPDATE SET value=s.value
WHEN NOT MATCHED THEN INSERT(id,value) VALUES(s.id,s.value);
SELECT * FROM lab_target ORDER BY id;

BEGIN;
SET LOCAL statement_timeout='5s';
SELECT current_setting('statement_timeout');
ROLLBACK;

SELECT grouping_id(region,category) AS gid,region,category,sum(amount) AS total
FROM (VALUES ('APAC','A',10::numeric),('APAC','B',20::numeric),('US','A',30::numeric)) v(region,category,amount)
GROUP BY ROLLUP(region,category) ORDER BY gid,region,category;

SELECT * FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) v(n) TABLESAMPLE SYSTEM (50);