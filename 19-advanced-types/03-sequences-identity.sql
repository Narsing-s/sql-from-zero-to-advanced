CREATE TEMP TABLE identity_demo (id bigint GENERATED ALWAYS AS IDENTITY, payload text);
INSERT INTO identity_demo(payload) VALUES ('a'),('b');
SELECT * FROM identity_demo;
