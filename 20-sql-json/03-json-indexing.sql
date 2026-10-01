CREATE TEMP TABLE json_search_demo(id bigint GENERATED ALWAYS AS IDENTITY, doc jsonb);
INSERT INTO json_search_demo(doc) VALUES ('{"status":"active","tags":["sql","etl"]}');
CREATE INDEX json_search_demo_gin ON json_search_demo USING gin (doc);
SELECT * FROM json_search_demo WHERE doc @> '{"status":"active"}';
