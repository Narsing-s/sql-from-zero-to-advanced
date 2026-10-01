CREATE SCHEMA IF NOT EXISTS learning;
SET search_path TO learning;

CREATE TABLE IF NOT EXISTS installation_check (
    id BIGSERIAL PRIMARY KEY,
    checked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    message TEXT NOT NULL
);

INSERT INTO installation_check (message)
VALUES ('PostgreSQL learning environment is ready');

SELECT version();
SELECT * FROM installation_check ORDER BY id DESC;
