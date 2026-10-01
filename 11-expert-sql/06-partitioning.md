# Table Partitioning

Partitioning splits one logical table into smaller physical pieces.

Typical strategy:
- **Range**: dates or numeric ranges.
- **List**: regions/status categories.
- **Hash**: distribute rows across partitions.

Example concept:

```sql
CREATE TABLE audit_events (
  event_id BIGINT,
  event_time TIMESTAMPTZ NOT NULL,
  payload JSONB
) PARTITION BY RANGE (event_time);
```

Why it matters:
- Partition pruning can reduce scanned data.
- Maintenance can be isolated to partitions.
- Partitioning is not a replacement for indexes or good query design.

Practice: design monthly partitions for a 500-million-row transaction history.
