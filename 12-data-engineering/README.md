# 12 — SQL for Data Engineering & Analytics

## Goal
Use SQL for reliable data movement, transformation and analytical workloads.

## Foundations
- OLTP vs OLAP
- ETL vs ELT
- staging tables
- batch processing
- streaming concepts
- CDC

## Data quality
- validation
- profiling
- deduplication
- reconciliation
- completeness
- uniqueness
- referential checks
- late-arriving data

## Incremental processing
- full load
- incremental load
- watermarks
- checkpoints
- retry safety
- idempotency

## Analytics
- fact and dimension tables
- grain
- star and snowflake schemas
- slowly changing dimensions
- cohort analysis
- retention
- funnel analysis
- time-series reporting

## Production model
Source → Validate → Stage → Transform → Load → Verify → Monitor → Recover

Every pipeline should define what happens when a batch partially fails.
