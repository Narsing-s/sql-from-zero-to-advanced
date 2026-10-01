# 57 — Client Integration Runnable Labs

Stage 46 documents database-client integration, but a runnable curriculum needs small executable examples too.

## Included clients
- Python `psycopg`
- Java JDBC
- Node.js `pg`

## Required behavior
Every example demonstrates:
- parameterized SQL
- transaction boundaries
- rollback on failure
- connection cleanup
- statement/query timeout where supported
- basic error handling
- no credentials committed to source

These examples target the disposable PostgreSQL CI/container environment and are not production credentials or production connection examples.