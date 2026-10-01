# 45 — PostgreSQL CI Integration

This stage turns the curriculum into an automated PostgreSQL test suite.

PostgreSQL itself uses regression testing, isolation testing and TAP tests; this repository follows the same principle at a smaller educational scale. The official PostgreSQL 18 documentation describes regression, isolation and TAP testing as distinct test mechanisms. 

## CI layers

1. Start PostgreSQL 18.6.
2. Apply deterministic fixtures.
3. Run safe SQL labs.
4. Run assertions/verification queries.
5. Run migration smoke tests.
6. Run PostgreSQL-specific tests separately from generic SQL.
7. Publish failures as CI artifacts.
8. Keep destructive/recovery/replication labs opt-in.

## Directory contract

- `fixtures/` — deterministic seed data
- `tests/` — executable checks
- `expected/` — stable expected results where practical
- `scripts/` — CI helpers
- `.github/workflows/` — GitHub Actions

The CI suite must never use production credentials or a production database.