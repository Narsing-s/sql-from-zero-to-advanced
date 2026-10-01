# 02 — Intermediate SQL

## Goal
Combine tables, groups and conditional logic to answer business questions.

## JOINs
A JOIN combines rows using a relationship.

    SELECT c.name, a.account_number, a.balance
    FROM bank.customers c
    JOIN bank.accounts a
      ON a.customer_id = c.customer_id;

Main types:
- INNER JOIN — matching rows
- LEFT JOIN — all left rows plus matches
- RIGHT JOIN — all right rows plus matches
- FULL JOIN — all rows from both sides
- CROSS JOIN — every combination
- SELF JOIN — a table related to itself

## GROUP BY
GROUP BY creates groups before aggregate calculations.

    SELECT customer_id, COUNT(*) AS account_count
    FROM bank.accounts
    GROUP BY customer_id;

Think: bucket rows → calculate each bucket.

## WHERE vs HAVING
WHERE filters rows before grouping. HAVING filters groups after grouping.

## Subqueries
Learn scalar subqueries, EXISTS, IN, correlated subqueries and ANY/ALL.

## CASE
CASE expresses conditional business rules.

## Common mistakes
- Joining on the wrong columns
- Accidentally multiplying rows
- Using WHERE instead of HAVING
- Ignoring NULL behavior in NOT IN
- Grouping at the wrong grain

## Practice
Write: tables → relationship → filters → grouping → calculation → result before writing SQL.

## Next
Continue to 03 — Advanced SQL.
