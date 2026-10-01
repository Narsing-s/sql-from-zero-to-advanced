# 07 — Database Security

## Goal
Protect data through authentication, authorization, safe SQL and controlled access.

## Mental model
Identity → Role → Privilege → Object → Data

## Learn
- authentication and authorization
- roles and inheritance
- GRANT and REVOKE
- default privileges and ownership
- least privilege
- Row-Level Security
- SECURITY DEFINER / INVOKER
- search_path security
- parameterized queries
- SQL injection
- TLS and encryption at rest
- secret management
- audit logging
- sensitive-data masking
- retention and deletion

## Golden rule
Never build SQL by concatenating untrusted input. Prefer parameterized statements.

## Practice
Create a read-only reporting role and verify that it cannot modify protected tables.

## Repository rule
Never commit real passwords, tokens, API keys or secret-bearing connection strings.
