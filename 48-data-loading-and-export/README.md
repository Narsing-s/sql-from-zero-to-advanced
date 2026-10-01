# 48 — Data Loading and Export

## Topics
- COPY FROM/TO
- psql \copy
- CSV/TSV
- JSON/JSONL ingestion patterns
- staging tables
- validation before promotion
- bad-row quarantine
- bulk INSERT
- batching
- ANALYZE after large loads
- load monitoring
- export consistency
- encoding and delimiter pitfalls
- large-object considerations

## Production pattern

Load into a staging area, validate, measure rejected rows, then promote validated data. Avoid mixing unvalidated external data directly into core business tables.