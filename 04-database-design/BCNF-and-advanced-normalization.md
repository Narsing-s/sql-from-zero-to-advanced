# BCNF and Advanced Normalization Theory

## BCNF

Boyce-Codd Normal Form (BCNF) is a stronger form of 3NF.

A relation is in BCNF when every determinant of a non-trivial functional dependency is a candidate key.

### Why it matters

3NF can permit certain dependencies that BCNF rejects. BCNF is useful when subtle redundancy remains even after 3NF.

### Trade-off

Decomposition can improve integrity but may increase JOIN complexity. Database design is a balance between correctness, maintainability and workload requirements.

## Temporal Data

Temporal data represents facts that change over time.

Examples:

- customer address history
- account status history
- employee salary history

Important questions:

- What was true at a particular time?
- When did the fact become valid?
- When did the system learn it?
- Should historical records remain immutable?

## Soft Delete

Soft delete marks a row as inactive instead of physically deleting it.

Example:

```sql
UPDATE customers
SET deleted_at = CURRENT_TIMESTAMP
WHERE customer_id = 10;
```

### Risks

Every query may need to exclude deleted rows. Uniqueness rules may also require partial unique indexes.

## Multi-Tenancy

Multi-tenancy means multiple customers/organizations share an application or database.

Common approaches:

1. shared tables with tenant_id
2. separate schemas
3. separate databases

Shared-table designs require strong tenant isolation, often with Row-Level Security.

## Hierarchical Data

Examples include:

- employee → manager
- category → parent category
- folder → parent folder

Common approaches:

- adjacency list
- recursive CTE
- materialized path
- closure table

Choose based on read/write patterns.

## Data Retention

Retention defines how long information should remain available.

Retention design should consider:

- legal/business requirements
- storage cost
- audit needs
- deletion requirements
- backups and replicas
- archived data

A DELETE from the primary database does not automatically mean every backup or replica has immediately forgotten the data.
