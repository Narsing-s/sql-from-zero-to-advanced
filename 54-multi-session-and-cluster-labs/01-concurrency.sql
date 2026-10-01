\set ON_ERROR_STOP on
DROP SCHEMA IF EXISTS concurrency_lab CASCADE;
CREATE SCHEMA concurrency_lab;
CREATE TABLE concurrency_lab.jobs (id bigint PRIMARY KEY,status text NOT NULL CHECK (status IN ('ready','running','done')),payload text NOT NULL);
INSERT INTO concurrency_lab.jobs VALUES (1,'ready','job-a'),(2,'ready','job-b'),(3,'ready','job-c');
-- Session A: BEGIN; SELECT * FROM concurrency_lab.jobs WHERE id=1 FOR UPDATE;
-- Session B: SELECT * FROM concurrency_lab.jobs WHERE id=1 FOR UPDATE NOWAIT; expected lock-not-available.
-- Queue pattern: BEGIN; SELECT id,payload FROM concurrency_lab.jobs WHERE status='ready' ORDER BY id FOR UPDATE SKIP LOCKED LIMIT 1; UPDATE concurrency_lab.jobs SET status='running' WHERE id=<selected_id>; COMMIT;
SELECT id,status,payload FROM concurrency_lab.jobs ORDER BY id;