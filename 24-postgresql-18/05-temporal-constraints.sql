-- PostgreSQL 18 — temporal constraints
-- Requires PostgreSQL 18+. Run in a disposable database.
-- Demonstrates WITHOUT OVERLAPS and PERIOD foreign keys.

DROP TABLE IF EXISTS temporal_child CASCADE;
DROP TABLE IF EXISTS temporal_parent CASCADE;

CREATE TABLE temporal_parent (
  entity_id integer NOT NULL,
  valid_during daterange NOT NULL,
  description text,
  PRIMARY KEY (entity_id, valid_during WITHOUT OVERLAPS)
);

INSERT INTO temporal_parent VALUES
  (1, daterange('2026-01-01','2026-04-01','[)'), 'contract A'),
  (1, daterange('2026-04-01','2026-07-01','[)'));

-- The temporal primary key prevents overlapping periods for the same entity.
-- This statement should fail because it overlaps an existing period:
-- INSERT INTO temporal_parent VALUES
--   (1, daterange('2026-03-01','2026-05-01','[)'), 'overlap');

CREATE TABLE temporal_child (
  entity_id integer NOT NULL,
  valid_during daterange NOT NULL,
  detail text,
  FOREIGN KEY (entity_id, PERIOD valid_during)
    REFERENCES temporal_parent (entity_id, PERIOD valid_during)
);

-- Every child period must be covered by the parent's matching entity periods.
INSERT INTO temporal_child VALUES
  (1, daterange('2026-01-15','2026-02-15','[)'), 'covered child');

-- This should fail because no parent coverage exists:
-- INSERT INTO temporal_child VALUES
--   (1, daterange('2026-07-01','2026-08-01','[)'), 'uncovered child');

SELECT * FROM temporal_parent ORDER BY entity_id, valid_during;
SELECT * FROM temporal_child ORDER BY entity_id, valid_during;

DROP TABLE temporal_child;
DROP TABLE temporal_parent;
