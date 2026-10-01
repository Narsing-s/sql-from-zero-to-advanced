\set ON_ERROR_STOP on
CREATE SCHEMA IF NOT EXISTS ci_types;

DROP TABLE IF EXISTS ci_types.accounts CASCADE;
CREATE TABLE ci_types.accounts (
  account_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email text NOT NULL UNIQUE,
  balance numeric(14,2) NOT NULL CHECK (balance >= 0),
  status text NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','BLOCKED'))
);

INSERT INTO ci_types.accounts(email,balance) VALUES ('ci@example.test',100.00);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid='ci_types.accounts'::regclass AND contype='p'
  ) THEN RAISE EXCEPTION 'primary key assertion failed'; END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid='ci_types.accounts'::regclass AND contype='u'
  ) THEN RAISE EXCEPTION 'unique constraint assertion failed'; END IF;
END $$;