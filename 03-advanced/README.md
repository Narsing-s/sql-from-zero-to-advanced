# 03 — Advanced SQL

## Goal
Express multi-step business logic clearly and safely.

## CTEs
A Common Table Expression (WITH) names an intermediate result.

    WITH customer_totals AS (
      SELECT customer_id, SUM(amount) AS total_amount
      FROM bank.transactions
      GROUP BY customer_id
    )
    SELECT *
    FROM customer_totals
    WHERE total_amount > 100000;

Mental model: source data → named intermediate result → final query.

## Recursive CTEs
Useful for employee hierarchies, category trees and dependency chains. Always define a termination condition.

## Window functions
GROUP BY reduces rows. Window functions calculate across related rows while retaining the original rows.

    SELECT account_id, transaction_date, amount,
           SUM(amount) OVER (
             PARTITION BY account_id
             ORDER BY transaction_date
           ) AS running_total
    FROM bank.transactions;

PARTITION BY defines calculation groups; ORDER BY defines calculation order.

## Views
A view stores a reusable query definition.

## Functions, procedures and triggers
- Function — reusable database logic
- Procedure — callable database operation
- Trigger — automatic reaction to a database event

Triggers can hide side effects, so document them carefully.

## Advanced query checklist
Input → Relationships → Grain → Filters → Transformation → Aggregation → Windowing → Ordering → Output

## Next
Continue to 04 — Database Design.
