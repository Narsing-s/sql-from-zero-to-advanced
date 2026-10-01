# 50 — Logical Replication Lab

A dedicated two-node PostgreSQL lab should demonstrate:

1. publisher database
2. publication
3. subscriber database
4. subscription
5. initial table synchronization
6. ongoing INSERT/UPDATE/DELETE replication
7. replication slot inspection
8. lag/worker monitoring
9. conflicts
10. row filters and column lists
11. generated-column replication
12. upgrade considerations
13. clean teardown

Logical replication uses a publish/subscribe model and can replicate selected tables or columns. PostgreSQL 18 documents row filters, column lists, conflict handling, monitoring and upgrade procedures as part of the logical replication feature set.

This lab is intentionally not part of the normal PR CI job because it needs multiple PostgreSQL instances and special server settings.