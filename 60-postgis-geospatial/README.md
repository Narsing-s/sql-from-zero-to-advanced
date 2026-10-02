# 60 — PostGIS & Geospatial SQL (Optional)

PostGIS is an extension ecosystem for spatial data. It is intentionally optional because it requires the PostGIS extension/container rather than core PostgreSQL.

## Learning goals
- geometry vs geography
- SRID and coordinate reference systems
- points, lines and polygons
- spatial predicates
- distance and nearest-neighbor concepts
- GiST/SP-GiST spatial indexes
- bounding-box filtering
- spatial data quality and invalid geometries
- coordinate-system mistakes
- application/API integration

Run these labs in a disposable Docker/PostGIS environment. Do not install extensions into production solely to follow this lesson.

Before a spatial query, establish the coordinate system, units, geometry validity, and expected index behavior.
