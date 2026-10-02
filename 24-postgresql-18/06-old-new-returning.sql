-- PostgreSQL 18 — OLD/NEW in DML RETURNING
-- Requires PostgreSQL 18+. Run in a disposable database.

DROP TABLE IF EXISTS returning_demo;

CREATE TABLE returning_demo (
  id integer PRIMARY KEY,
  status text NOT NULL,
  amount numeric(12,2) NOT NULL
);

INSERT INTO returning_demo VALUES (1, 'NEW', 100.00);

UPDATE returning_demo
SET status = 'PAID', amount = amount + 25
WHERE id = 1
RETURNING OLD.status AS old_status,
          NEW.status AS new_status,
          OLD.amount AS old_amount,
          NEW.amount AS new_amount;

DELETE FROM returning_demo
WHERE id = 1
RETURNING OLD.id AS deleted_id,
          OLD.status AS deleted_status,
          OLD.amount AS deleted_amount;

DROP TABLE returning_demo;
