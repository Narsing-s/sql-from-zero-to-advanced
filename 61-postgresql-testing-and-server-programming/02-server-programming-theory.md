# Server Programming Theory

## 1. What is server-side programming?

Server-side programming places reusable logic close to PostgreSQL data and execution. PostgreSQL provides PL/pgSQL, triggers, event triggers, logical decoding, background workers, and extension interfaces.

## 2. PL/pgSQL vs SQL function

A SQL function is often preferable when logic is a straightforward SQL expression or query.

PL/pgSQL is useful when logic needs variables, branching, loops, exception handling, or multi-step SQL orchestration.

## 3. Trigger

A trigger automatically executes a function in response to table events such as INSERT, UPDATE, or DELETE.

Use triggers when an invariant truly belongs at the database boundary.

Risks include hidden side effects, recursive behavior, unexpected latency, difficult debugging, and bulk-load surprises.

## 4. Event trigger

An event trigger operates on database-level events such as DDL. It is useful for controlled DDL auditing and governance.

## 5. Logical decoding

Logical decoding exposes database changes from WAL in a logical representation. It is a foundation for CDC and replication tooling.

Design concerns include replication-slot WAL retention, consumer progress, schema evolution, and duplicate/retry semantics.

## 6. Background workers

Background workers allow extension code to execute server-side processes. They are an extension-development concern rather than ordinary application SQL.

## 7. Extension architecture

A PostgreSQL extension packages database objects and optionally compiled server-side code.

A production extension should define installation, upgrade path, versioning, dependencies, permissions, rollback expectations, and automated tests.

## 8. Archive modules

PostgreSQL 18 provides infrastructure for custom WAL archive modules. A custom module can implement controlled archival behavior through callbacks.

This is advanced extension development, not ordinary application SQL.

## 9. OAuth validator modules

PostgreSQL 18 provides infrastructure for custom OAuth bearer-token validation modules. These are dynamically loaded server libraries and require careful security design because a faulty validator can affect database authentication.

PostgreSQL does not ship a default OAuth validator implementation; a validator library must be provided separately.

## 10. SQL vs PL/pgSQL vs extension vs application

| Need | Typical boundary |
|---|---|
| Simple relational query | SQL |
| Small reusable database calculation | SQL function |
| Multi-step transactional database logic | PL/pgSQL |
| Row-level invariant | Trigger/constraint |
| DDL governance | Event trigger |
| CDC transformation | Logical decoding / external consumer |
| Custom server behavior | Extension |
| Complex business workflow | Application/service |

The correct boundary depends on operational, security, performance, and ownership constraints.

## 11. Security rules

Avoid dynamic SQL built from untrusted text. Prefer parameters and safe identifier handling.

For privileged functions:

- minimize privileges
- validate search_path
- avoid unsafe dynamic SQL
- document SECURITY DEFINER behavior
- test authorization paths
- review ownership and grants

## 12. Operational rule

Server-side code is production software. Apply version control, code review, automated tests, observability, migration discipline, rollback planning, and security review.
