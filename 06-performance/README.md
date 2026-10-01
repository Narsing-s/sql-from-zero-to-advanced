# 06 — SQL Performance

## Goal
Learn how PostgreSQL executes SQL and investigate slow queries using evidence.

## Mental model
SQL → Parser → Planner → Execution Plan → Executor → Result

Measure before changing anything.

## Learn
- scans: sequential, index, index-only, bitmap
- joins: nested loop, hash, merge
- sorting and aggregation
- cardinality and selectivity
- statistics and ANALYZE
- EXPLAIN and EXPLAIN ANALYZE
- BUFFERS and I/O timing
- sargability
- index design
- pagination and keyset pagination
- N+1 queries
- temporary spills
- parallel query
- partition pruning
- timeouts
- plan regressions

## Investigation
Symptom → Reproduce → EXPLAIN → Identify bottleneck → Change one thing → Measure again

## Example
    EXPLAIN (ANALYZE, BUFFERS)
    SELECT *
    FROM bank.transactions
    WHERE account_id = 10;

## Common mistakes
- Adding indexes without measuring
- Indexing every column
- Ignoring stale statistics
- Comparing plans on different data
- Running expensive EXPLAIN ANALYZE writes carelessly in production

## Next
Continue to 07 — Security.
