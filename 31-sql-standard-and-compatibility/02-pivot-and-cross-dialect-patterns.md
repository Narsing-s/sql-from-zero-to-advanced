# Pivoting and Cross-Dialect Patterns

PostgreSQL does not provide a SQL Server/Oracle-style PIVOT/UNPIVOT syntax as a general core statement. Learn portable patterns instead.

## Pivot with conditional aggregation

```sql
SELECT customer_id,
       SUM(amount) FILTER (WHERE status = 'PAID') AS paid_amount,
       SUM(amount) FILTER (WHERE status = 'REFUNDED') AS refunded_amount
FROM payments
GROUP BY customer_id;
```

A portable CASE approach is:

```sql
SELECT customer_id,
       SUM(CASE WHEN status = 'PAID' THEN amount ELSE 0 END) AS paid_amount,
       SUM(CASE WHEN status = 'REFUNDED' THEN amount ELSE 0 END) AS refunded_amount
FROM payments
GROUP BY customer_id;
```

## Unpivot concept

Normalize repeated columns back into rows with UNION ALL, VALUES, or engine-specific JSON/array techniques depending on the data shape.

## Transfer rule

When moving SQL between PostgreSQL, SQL Server, Oracle, MySQL and analytical platforms, distinguish standard SQL concepts, PostgreSQL-specific syntax, vendor-specific convenience syntax, and semantic differences that can change results.

Always test generated SQL on the target engine rather than assuming syntactic portability.
