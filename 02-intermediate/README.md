# 02 — Intermediate SQL

## Goal
Combine tables, groups, subqueries and set operations to answer business questions.

## JOINs
A JOIN combines rows using a relationship.

Main types:
- INNER JOIN — matching rows
- LEFT JOIN — all left rows plus matches
- RIGHT JOIN — all right rows plus matches
- FULL JOIN — all rows from both sides
- CROSS JOIN — every combination
- SELF JOIN — a table related to itself

See **[01-joins.sql](01-joins.sql)** for complete examples, join multiplication and EXISTS.

## GROUP BY and aggregation
GROUP BY creates groups before aggregate calculations.

    SELECT customer_id, COUNT(*) AS account_count
    FROM bank.accounts
    GROUP BY customer_id;

Think: bucket rows → calculate each bucket.

## WHERE vs HAVING
WHERE filters rows before grouping. HAVING filters groups after grouping.

## Subqueries and predicates
Learn:
- Scalar subqueries
- Subqueries in WHERE/FROM
- Correlated subqueries
- EXISTS / NOT EXISTS
- IN / NOT IN
- ANY / ALL

See **[04-subqueries.sql](04-subqueries.sql)** and **[07-exists-in-any-all.sql](07-exists-in-any-all.sql)**.

## Set operations
Learn:
- UNION
- UNION ALL
- INTERSECT
- EXCEPT

See **[06-set-operations.sql](06-set-operations.sql)**.

## CASE
CASE expresses conditional business rules.

## Common mistakes
- Joining on the wrong columns
- Accidentally multiplying rows
- Using WHERE instead of HAVING
- Ignoring NULL behavior in NOT IN
- Grouping at the wrong grain
- Combining SELECTs with incompatible column counts/types

## Practice
Write: tables → relationship → filters → grouping → calculation → result before writing SQL.

## Next
Continue to 03 — Advanced SQL.
