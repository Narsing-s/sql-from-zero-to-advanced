# PostgreSQL Version Matrix

PostgreSQL is the primary executable dialect.

| Area | Older supported releases | PostgreSQL 18 |
|---|---|---|
| Core SQL | Broad overlap | Current target |
| JSON/JSONB | Supported | Supported |
| Logical replication | Supported | Version-specific behavior |
| Generated columns | Stored | Virtual generated columns available |
| UUID v7 | Not built-in | Built-in |
| OLD/NEW in RETURNING | Not generally available | Supported |
| AIO and planner behavior | Different | PostgreSQL 18-specific |

Mark PostgreSQL-18-specific labs explicitly.