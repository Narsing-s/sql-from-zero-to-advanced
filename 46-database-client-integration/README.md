# 46 — Database Client Integration

SQL does not execute in isolation in real applications. This stage covers the boundary between application code and PostgreSQL.

## Topics
- JDBC and transaction boundaries
- Python/psycopg
- Node.js/node-postgres
- connection pools
- prepared statements
- parameter binding
- server-side versus client-side timeouts
- transaction retries
- serialization failures
- deadlock retries
- idempotency keys
- pagination
- streaming/cursors
- observability and correlation IDs
- safe error handling

## Rule

Application code should parameterize values rather than concatenate SQL strings. Retry only operations whose transaction semantics are understood and whose business operation is safe to retry.