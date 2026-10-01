# WAL, checkpoints and vacuum

Study the relationship between WAL durability, checkpoints, MVCC dead tuples, VACUUM and ANALYZE.

Exercise: modify a disposable dataset, inspect pg_stat_all_tables, run ANALYZE, compare planner estimates, then run VACUUM (VERBOSE, ANALYZE). Explain why VACUUM is not a backup.
