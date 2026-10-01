SELECT version();
SELECT uuidv7() AS time_ordered_uuid;
CREATE TEMP TABLE generated_demo (a integer, b integer, total integer GENERATED ALWAYS AS (a+b) VIRTUAL, stored_total integer GENERATED ALWAYS AS (a+b) STORED);
INSERT INTO generated_demo(a,b) VALUES (2,3);
SELECT * FROM generated_demo;
