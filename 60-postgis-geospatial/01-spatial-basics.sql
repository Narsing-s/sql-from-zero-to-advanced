-- Run with PostGIS installed:
-- CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TEMP TABLE spatial_demo (
  id integer PRIMARY KEY,
  name text NOT NULL,
  location geometry(Point, 4326) NOT NULL
);

INSERT INTO spatial_demo VALUES
  (1, 'A', ST_SetSRID(ST_MakePoint(83.2185, 17.6868), 4326)),
  (2, 'B', ST_SetSRID(ST_MakePoint(78.4867, 17.3850), 4326));

SELECT id, name, ST_AsText(location) AS point_wkt
FROM spatial_demo;

SELECT ST_Distance(
  location::geography,
  ST_SetSRID(ST_MakePoint(83.2185, 17.6868), 4326)::geography
) AS distance_meters
FROM spatial_demo
ORDER BY distance_meters;
