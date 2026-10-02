# Spatial Index & Data Quality Lab

A production spatial workflow should demonstrate:

1. Create a GiST index on the spatial column.
2. Use EXPLAIN (ANALYZE, BUFFERS) to verify whether the index is useful.
3. Validate geometries with PostGIS validity functions.
4. Reject or quarantine invalid input.
5. Confirm SRIDs before distance/intersection calculations.
6. Test realistic spatial selectivity; tiny datasets may correctly choose a sequential scan.

Do not assume an index is used merely because it exists.
