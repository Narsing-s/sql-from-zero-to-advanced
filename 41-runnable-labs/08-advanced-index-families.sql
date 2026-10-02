-- 41.8 — Advanced index families
-- PostgreSQL 18+ compatible. Run in a disposable database.
-- Demonstrates B-tree, Hash, GIN, GiST, SP-GiST and BRIN use cases.

DROP TABLE IF EXISTS advanced_index_lab;
CREATE TABLE advanced_index_lab (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tenant_id integer NOT NULL,
  event_time timestamptz NOT NULL,
  tags text[] NOT NULL DEFAULT '{}',
  document tsvector,
  location point,
  ip inet
);

INSERT INTO advanced_index_lab (tenant_id,event_time,tags,document,location,ip)
SELECT
  (g % 100)+1,
  now() - (g || ' minutes')::interval,
  ARRAY[CASE WHEN g%2=0 THEN 'active' ELSE 'archived' END, 'tag-'||(g%10)],
  to_tsvector('english','customer order payment service ' || g),
  point((g%100)::float8,(g%50)::float8),
  ('10.0.'||(g%255)||'.'||((g/255)%255))::inet
FROM generate_series(1,10000) AS g;

CREATE INDEX advanced_btree_idx ON advanced_index_lab(tenant_id, event_time);
CREATE INDEX advanced_hash_idx ON advanced_index_lab USING hash(tenant_id);
CREATE INDEX advanced_gin_tags_idx ON advanced_index_lab USING gin(tags);
CREATE INDEX advanced_gin_fts_idx ON advanced_index_lab USING gin(document);
CREATE INDEX advanced_gist_location_idx ON advanced_index_lab USING gist(location);
CREATE INDEX advanced_spgist_ip_idx ON advanced_index_lab USING spgist(ip);
CREATE INDEX advanced_brin_time_idx ON advanced_index_lab USING brin(event_time);

ANALYZE advanced_index_lab;

EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM advanced_index_lab
WHERE tenant_id = 42
ORDER BY event_time DESC
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) FROM advanced_index_lab WHERE tags @> ARRAY['active'];

EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) FROM advanced_index_lab
WHERE document @@ plainto_tsquery('english','customer payment');

-- BRIN is useful for naturally ordered large tables; this small lab is
-- intentionally demonstrative, not a benchmark.
EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) FROM advanced_index_lab
WHERE event_time > now() - interval '10 minutes';

-- Inspect indexes and access methods.
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'advanced_index_lab'
ORDER BY indexname;

SELECT amname
FROM pg_am
WHERE amname IN ('btree','hash','gin','gist','spgist','brin')
ORDER BY amname;

DROP TABLE advanced_index_lab;
