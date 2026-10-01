\set ON_ERROR_STOP on
SHOW server_version;
SHOW server_encoding;
SHOW TimeZone;
CREATE SCHEMA IF NOT EXISTS audit_lab;
DROP TABLE IF EXISTS audit_lab.sample;
CREATE TABLE audit_lab.sample (id integer PRIMARY KEY, value text NOT NULL, created_at timestamptz NOT NULL);
INSERT INTO audit_lab.sample VALUES (1,'alpha',TIMESTAMPTZ '2026-01-01 00:00:00+00'),(2,'beta',TIMESTAMPTZ '2026-01-02 00:00:00+00');
SELECT id,value FROM audit_lab.sample ORDER BY id;
SELECT id,created_at AT TIME ZONE 'UTC' AS created_at_utc FROM audit_lab.sample ORDER BY id;
DO $$ BEGIN IF (SELECT count(*) FROM audit_lab.sample) <> 2 THEN RAISE EXCEPTION 'deterministic fixture assertion failed'; END IF; END $$;