# Connection Pooling

A connection is a server-side resource. Pool size should be derived from database capacity and workload, not simply application thread count.

Checklist:
- define a connection budget per service
- reserve capacity for administration and replication
- configure connection, statement and idle-in-transaction timeouts deliberately
- measure pool wait time separately from SQL execution time
- keep transactions short
- avoid one database connection per request
- evaluate PgBouncer when pooling solves a real connection-management problem

Failure drill: distinguish application-pool waiting, PostgreSQL max_connections exhaustion, slow SQL holding connections, and idle-in-transaction sessions.