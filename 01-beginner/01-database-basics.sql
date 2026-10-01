CREATE SCHEMA IF NOT EXISTS beginner;
SET search_path TO beginner;

CREATE TABLE customers (
    customer_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE,
    date_of_birth DATE,
    city VARCHAR(80),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

SELECT table_name FROM information_schema.tables
WHERE table_schema = 'beginner';
