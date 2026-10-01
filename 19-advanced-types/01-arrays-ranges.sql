CREATE TEMP TABLE advanced_types_demo (id bigint GENERATED ALWAYS AS IDENTITY, tags text[], active_period tstzrange);
INSERT INTO advanced_types_demo(tags, active_period) VALUES (ARRAY['sql','postgres'], tstzrange(now(), now()+interval '30 days','[)'));
SELECT id, tags, active_period, 'postgres' = ANY(tags) AS has_postgres FROM advanced_types_demo;
SELECT * FROM advanced_types_demo WHERE active_period @> now();
