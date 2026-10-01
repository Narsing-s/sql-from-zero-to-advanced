# SQL 101 Best Practices

A beginner-friendly, original checklist for writing SQL that is readable, safe, correct, and maintainable.

## Core practices
- Use descriptive names for tables, columns, keys, indexes, and constraints.
- Format SQL consistently so clauses and join conditions are easy to review.
- Select only the columns required instead of relying on SELECT *.
- Treat NULL deliberately; use IS NULL and IS NOT NULL.
- Before UPDATE or DELETE, run the equivalent SELECT with the same WHERE condition.
- Use transactions when multiple related writes must succeed together.
- Prefer PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, and CHECK constraints for integrity.
- Add indexes based on actual access patterns and validate them with EXPLAIN.
- Parameterize application SQL; never concatenate untrusted input into SQL.
- Distinguish validation, constraint, timeout, transient, and unexpected database errors.
- Test empty results, NULLs, duplicates, boundary dates, retries, and concurrent updates.
- Measure query performance before changing a query.
- Version and review schema migrations.
- Document PostgreSQL-specific behavior when portability matters.

## Safe write pattern

Before:
SELECT * FROM customers WHERE customer_id = 101;

Then, after verifying the target:
UPDATE customers
SET email = 'new@example.com'
WHERE customer_id = 101;

## Transaction pattern

BEGIN;
-- related writes
-- verify expected state
COMMIT;

Use ROLLBACK when validation fails.

## Production checklist
- [ ] Clear names
- [ ] Readable formatting
- [ ] Explicit JOIN conditions
- [ ] Intentional NULL handling
- [ ] Verified UPDATE/DELETE targets
- [ ] Appropriate transaction boundaries
- [ ] Integrity constraints
- [ ] Justified indexes
- [ ] Parameterized inputs
- [ ] Explicit error handling
- [ ] Edge-case tests
- [ ] Measured performance
- [ ] Versioned migrations
- [ ] Documented dialect differences

A good SQL query should be understandable, safe under failure, correct under concurrency, appropriate for data volume, and maintainable by the next engineer.
