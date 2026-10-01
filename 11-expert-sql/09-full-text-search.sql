-- PostgreSQL full-text search uses tsvector/tsquery.
SELECT to_tsvector('english', 'SQL performance tuning for production databases')
       @@ plainto_tsquery('english', 'performance database') AS matches;

-- Practice: add a searchable document column and create a GIN index.
