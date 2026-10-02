-- PostgreSQL recursive SEARCH/CYCLE example.
-- Use a disposable table for experimentation.

CREATE TEMP TABLE org_chart (
  employee_id integer PRIMARY KEY,
  manager_id integer,
  name text NOT NULL
);

INSERT INTO org_chart VALUES
  (1, NULL, 'CEO'),
  (2, 1, 'Engineering'),
  (3, 2, 'Platform'),
  (4, 2, 'Applications');

WITH RECURSIVE tree(employee_id, manager_id, name, depth) AS (
  SELECT employee_id, manager_id, name, 0
  FROM org_chart
  WHERE manager_id IS NULL

  UNION ALL

  SELECT c.employee_id, c.manager_id, c.name, t.depth + 1
  FROM org_chart c
  JOIN tree t ON c.manager_id = t.employee_id
)
SEARCH DEPTH FIRST BY employee_id SET search_order
SELECT employee_id, name, depth, search_order
FROM tree
ORDER BY search_order;

-- CYCLE protects recursive traversals from revisiting a node.
WITH RECURSIVE graph(from_id, to_id) AS (
  VALUES (1,2), (2,3), (3,1), (2,4)
),
walk(node) AS (
  SELECT 1
  UNION ALL
  SELECT g.to_id
  FROM walk w
  JOIN graph g ON g.from_id = w.node
)
CYCLE node SET is_cycle USING path
SELECT node, is_cycle, path
FROM walk;
