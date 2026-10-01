-- 01-Beginner / SQL Best Practices
--
-- WHAT IS THIS?
-- SQL best practices are habits that make SQL easier to read, safer to change,
-- easier to troubleshoot, and less likely to damage data.
--
-- WHY DOES IT MATTER?
-- A query can be syntactically correct and still be dangerous or difficult
-- to maintain. Professional SQL includes readability, safety and verification.
--
-- MENTAL MODEL
-- Understand → Format → Restrict → Preview → Change → Verify
--
-- 1. Use descriptive object names.
-- Prefer: customer_orders, order_items, created_at
-- Avoid: t1, x, abc, data1
--
-- 2. Prefer explicit columns over SELECT * in application/production queries.
SELECT customer_id, name, email
FROM beginner.customers;

-- 3. Format SQL so the logical steps are visible.
SELECT
    customer_id,
    name,
    city
FROM beginner.customers
WHERE city = 'Hyderabad'
ORDER BY name ASC;

-- 4. Treat UPDATE and DELETE as high-risk operations.
-- First run the WHERE clause as SELECT.
SELECT customer_id, name
FROM beginner.customers
WHERE customer_id = 1;

-- Only after confirming the target row:
-- UPDATE beginner.customers
-- SET email = 'new@example.com'
-- WHERE customer_id = 1;

-- 5. Never omit WHERE accidentally.
-- This changes every row:
-- UPDATE beginner.customers SET city = 'Hyderabad';
--
-- This deletes every row:
-- DELETE FROM beginner.customers;

-- 6. Use transactions for risky multi-step changes.
BEGIN;

UPDATE beginner.customers
SET email = 'verified@example.com'
WHERE customer_id = 1;

-- Inspect before committing:
SELECT customer_id, name, email
FROM beginner.customers
WHERE customer_id = 1;

-- COMMIT when verified.
-- ROLLBACK if the result is not what you expected.
ROLLBACK;

-- 7. Use constraints to protect data instead of relying only on application code.
-- Primary key, foreign key, UNIQUE, NOT NULL and CHECK are database rules.
--
-- 8. Use parameters in application code.
-- Never build SQL by concatenating untrusted user input.
--
-- 9. Do not assume row order without ORDER BY.
SELECT customer_id, name
FROM beginner.customers
ORDER BY customer_id;

-- 10. Understand NULL.
-- NULL means unknown/missing, not zero and not an empty string.
SELECT customer_id, name
FROM beginner.customers
WHERE email IS NULL;

-- 11. Validate changes.
-- A production UPDATE/DELETE should normally be followed by checks such as
-- affected-row counts, targeted SELECTs, constraints and application tests.
--
-- 12. Performance is part of correctness at scale.
-- A query that works on 100 rows may become operationally unsafe on 100 million.
-- Learn EXPLAIN, indexes, statistics and query plans in Stage 06.
--
-- 13. PostgreSQL error handling.
-- PostgreSQL does not use SQL Server-style TRY/CATCH syntax.
-- Server-side exception handling is available through PL/pgSQL EXCEPTION blocks
-- inside functions/procedures. Application code should also handle database errors.
--
-- 14. Code review checklist:
-- [ ] Correct tables and columns
-- [ ] Correct WHERE condition
-- [ ] NULL behavior understood
-- [ ] Constraints respected
-- [ ] Transaction boundary appropriate
-- [ ] Query formatted and readable
-- [ ] Parameterized when used by an application
-- [ ] Performance considered
-- [ ] Result/change verified
--
-- PRACTICE
-- 1. Write a SELECT that previews customers before an UPDATE.
-- 2. Write a transaction that changes one customer and then ROLLBACK.
-- 3. Explain why SELECT * can be undesirable in production applications.
-- 4. Explain why ORDER BY is required when a deterministic order is needed.
--
-- INTERVIEW
-- Q: Why should UPDATE/DELETE usually be preceded by a SELECT?
-- A: It lets you verify exactly which rows the condition targets before changing data.
--
-- Q: Does correct SQL automatically mean safe SQL?
-- A: No. Safety also depends on scope, constraints, transactions, permissions,
-- parameterization, concurrency and verification.
