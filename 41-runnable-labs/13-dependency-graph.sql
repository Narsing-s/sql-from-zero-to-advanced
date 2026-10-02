-- 41.13 — PostgreSQL dependency graph lab
-- Disposable database. pg_depend is a PostgreSQL system catalog and is
-- useful when planning DDL changes, drops, migrations and refactoring.

DROP TABLE IF EXISTS dependency_child CASCADE;
DROP TABLE IF EXISTS dependency_parent CASCADE;

CREATE TABLE dependency_parent (
  id bigint PRIMARY KEY,
  value text NOT NULL
);

CREATE TABLE dependency_child (
  id bigint PRIMARY KEY,
  parent_id bigint REFERENCES dependency_parent(id),
  value text
);

CREATE VIEW dependency_demo AS
SELECT c.id, c.parent_id, c.value
FROM dependency_child AS c;

-- Show dependencies of the demo view and table objects.
SELECT dependent.oid::regclass AS dependent_object,
       pg_describe_object(dep.classid, dep.objid, dep.objsubid) AS dependent_description,
       pg_describe_object(ref.classid, ref.objid, ref.objsubid) AS referenced_description
FROM pg_depend AS dep
JOIN pg_depend AS ref
  ON ref.objid = dep.refobjid
 AND ref.classid = dep.refclassid
 AND ref.objsubid = dep.refobjsubid
JOIN pg_class AS dependent
  ON dependent.oid = dep.objid
WHERE dep.classid = 'pg_class'::regclass
  AND dependent.oid IN (
    'dependency_demo'::regclass,
    'dependency_child'::regclass
  )
ORDER BY dependent_object, referenced_description;

-- A migration engineer should inspect dependencies before destructive DDL.
-- DROP TABLE dependency_parent CASCADE; -- intentionally not executed.

DROP VIEW dependency_demo;
DROP TABLE dependency_child;
DROP TABLE dependency_parent;
