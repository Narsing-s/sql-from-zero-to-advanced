# Schema Drift and Performance Regression

Verify tables, columns, types, nullability, constraints, indexes, routines, triggers, grants, default privileges, extensions and versions after migrations.

For representative queries capture EXPLAIN (ANALYZE, BUFFERS), execution time, rows, planning time where useful, and pg_stat_statements aggregates. Keep a baseline before major changes and compare after deployment.

A faster query is not automatically safer if result correctness, lock duration, memory, I/O or concurrency behavior regresses.