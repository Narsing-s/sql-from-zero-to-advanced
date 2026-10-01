# 18 — Schema Migrations

Production-safe database evolution: versioned migrations, idempotency, expand/contract, backward compatibility, lock-aware DDL, backfills, rollback/forward-fix, drift detection and CI validation.

Expand/contract: add new structure → dual compatibility → controlled backfill → validate → switch reads → remove old structure after a safe window.
