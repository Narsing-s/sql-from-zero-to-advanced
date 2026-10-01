-- ============================================================
-- 09 — PostgreSQL full-text search
-- ============================================================
--
-- Definition:
-- Full-text search converts text into searchable tokens and matches
-- those tokens with a tsquery. PostgreSQL provides tsvector and tsquery
-- for this purpose.
--
-- Purpose:
-- Learn the basic matching operation before building a searchable table.
--
-- Mental model:
-- Text -> to_tsvector() -> searchable representation
-- Search terms -> to_tsquery/plainto_tsquery -> query
-- Both -> @@ -> match/no match
--
-- Expected result:
-- The example returns true because the document contains concepts
-- matching the requested terms after English text processing.
--
-- Practice:
-- Add a document table with a generated/search column and create a
-- GIN index for larger datasets.
--
-- Performance:
-- For substantial text-search workloads, a GIN index on a tsvector
-- column can avoid repeatedly processing every document.
--
-- Security:
-- Treat search text as data and use parameters in application queries.
--
-- Production use:
-- Product search, help centres, document search, and operational notes.
--
-- Interview:
-- What are tsvector and tsquery, and what does @@ do?
-- ============================================================

SELECT to_tsvector(
         'english',
         'SQL performance tuning for production databases'
       )
       @@ plainto_tsquery('english', 'performance database') AS matches;

-- Practice: add a searchable document column and create a GIN index.
