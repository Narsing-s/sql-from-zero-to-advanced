# 59 — SQL Error Diagnostics & PL/pgSQL Exception Handling

This module covers database errors as structured data rather than text.

## Topics
- SQLSTATE and condition names
- constraint, serialization, deadlock and cancellation errors
- PL/pgSQL EXCEPTION blocks
- GET STACKED DIAGNOSTICS
- preserving useful error context
- retryable vs non-retryable errors
- application-facing error mapping
- why parsing error-message text is fragile

## Production rule
Prefer SQLSTATE/structured diagnostics over matching human-readable error strings. Retry only errors that are known to be transient and make the operation idempotent.
