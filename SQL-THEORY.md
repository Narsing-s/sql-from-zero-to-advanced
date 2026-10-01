# SQL Theory — From First Principles to Production

This document teaches **why SQL works**, not just which commands to type. Read the theory before running the matching examples in each folder.

## 1. What is SQL?

**SQL (Structured Query Language)** is the language used to work with relational databases.

A database stores information in a structured way. SQL lets you:

- define structures
- store data
- read data
- change data
- remove data
- enforce rules
- control access
- analyze data
- manage transactions
- investigate performance

Think of a database as a highly organized system of related tables. SQL is how you ask the system questions and tell it what changes are required.

### Database vs table vs row vs column

- **Database**: a logical container for related objects.
- **Table**: a structured collection of records.
- **Row**: one record.
- **Column**: one attribute of a record.
- **Primary key**: identifies a row uniquely.
- **Foreign key**: connects one table to another.

Example:

```text
customers
+----+----------+-------------+
| id | name     | city        |
+----+----------+-------------+
| 1  | Ravi     | Hyderabad   |
| 2  | Anu      | Visakhapatnam|
+----+----------+-------------+
```

One row represents one customer. A column describes one property of that customer.

---

## 2. Relational Database Theory

A relational database represents data as **relations**, commonly displayed as tables.

The important idea is not the visual table itself. The important idea is that data has:

1. defined attributes
2. defined relationships
3. rules that maintain correctness

### Why relationships matter

Suppose a customer can have multiple accounts. Storing the customer name repeatedly inside every account row creates duplication.

Instead:

```text
customers
customer_id -> 1

accounts
customer_id -> 1
```

The foreign key expresses the relationship.

This allows SQL to combine information when needed without copying the same customer data everywhere.

---

## 3. SQL Command Families

SQL is easier to understand when commands are grouped by purpose.

### DDL — Data Definition Language

Defines database structures.

Examples:

```sql
CREATE TABLE ...
ALTER TABLE ...
DROP TABLE ...
```

Think: **What should the database structure look like?**

### DML — Data Manipulation Language

Changes stored data.

Examples:

```sql
INSERT ...
UPDATE ...
DELETE ...
```

Think: **What data should exist?**

### DQL — Data Query Language

Reads data.

```sql
SELECT ...
```

Think: **What information do I need?**

### DCL — Data Control Language

Controls permissions.

```sql
GRANT ...
REVOKE ...
```

Think: **Who is allowed to do what?**

### Transaction control

Controls transaction boundaries.

```sql
BEGIN;
COMMIT;
ROLLBACK;
SAVEPOINT;
```

Think: **When should changes become permanent?**

---

## 4. How a SELECT Query Should Be Understood

A SELECT statement is a request for a result.

Example:

```sql
SELECT name, city
FROM customers
WHERE city = 'Hyderabad';
```

Read it as:

1. Start with the `customers` table.
2. Keep rows where city is Hyderabad.
3. Return the name and city columns.

The database does not simply execute the text from top to bottom. SQL describes the desired result, and the optimizer decides how to obtain it.

A simplified logical processing model is:

```text
FROM / JOIN
   ↓
WHERE
   ↓
GROUP BY
   ↓
HAVING
   ↓
SELECT
   ↓
DISTINCT
   ↓
ORDER BY
   ↓
LIMIT
```

This logical order explains many SQL errors and behaviors.

---

## 5. Filtering

Filtering reduces the rows that participate in the result.

```sql
SELECT *
FROM customers
WHERE age >= 18;
```

The condition is evaluated for each candidate row.

Common operators:

```text
=       equal
<>      not equal
>       greater than
<       less than
>=      greater than or equal
<=      less than or equal
AND     all conditions must be true
OR      at least one condition must be true
IN      matches a list
BETWEEN range comparison
LIKE    pattern matching
```

### Important theory

Use parentheses when combining AND and OR so the business rule is explicit.

---

## 6. NULL and Three-Valued Logic

NULL does not mean zero, empty text, false, or a missing string.

It means the value is **unknown or not present**.

SQL conditions can evaluate to:

- TRUE
- FALSE
- UNKNOWN

Example:

```sql
SELECT *
FROM customers
WHERE email = NULL;
```

This is not the correct way to find NULLs.

Use:

```sql
WHERE email IS NULL;
```

Why? Because comparing an unknown value with `=` produces UNKNOWN.

This is one of the most important SQL concepts.

---

## 7. Aggregation

Aggregation turns many rows into summarized information.

Common aggregate functions:

```text
COUNT()
SUM()
AVG()
MIN()
MAX()
```

Example:

```sql
SELECT customer_id, SUM(amount)
FROM transactions
GROUP BY customer_id;
```

Mental model:

> Divide rows into groups, then calculate something for each group.

`WHERE` filters rows **before** grouping.

`HAVING` filters groups **after** grouping.

---

## 8. JOIN Theory

A JOIN combines rows from related tables.

Example:

```sql
SELECT c.name, a.account_number
FROM customers c
JOIN accounts a
  ON a.customer_id = c.customer_id;
```

The database compares the join condition and produces matching combinations.

### Main join types

**INNER JOIN**
- returns matching rows from both sides.

**LEFT JOIN**
- keeps every row from the left table.
- unmatched right-side columns become NULL.

**RIGHT JOIN**
- keeps every row from the right table.

**FULL OUTER JOIN**
- keeps rows from both sides, matched where possible.

**CROSS JOIN**
- creates combinations of every left row with every right row.

### Common mistake

A missing or incorrect JOIN condition can create far more rows than expected.

---

## 9. Keys and Constraints

Constraints make the database protect data quality.

### Primary key

A primary key uniquely identifies a row.

```sql
PRIMARY KEY (customer_id)
```

### Foreign key

A foreign key requires a referenced value to exist.

```sql
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
```

### UNIQUE

Prevents duplicate values in a constrained key.

### NOT NULL

Requires a value.

### CHECK

Enforces a business condition.

```sql
CHECK (balance >= 0)
```

### Why constraints matter

Application validation is useful, but database constraints provide a final line of defense when multiple applications, scripts, users, or integrations write to the same database.

---

## 10. Normalization

Normalization organizes data to reduce unnecessary duplication and update anomalies.

### First Normal Form

Values should be atomic rather than storing repeated lists in one field.

Bad:

```text
phone_numbers = '111,222,333'
```

Better:

Use a related phone table when multiple phone numbers are genuine separate values.

### Second Normal Form

Non-key attributes should depend on the whole key when using a composite key.

### Third Normal Form

Non-key attributes should not depend on another non-key attribute.

### Important production balance

Normalization improves correctness and maintainability, but highly analytical workloads may intentionally use denormalized structures for performance.

Design should follow workload, not dogma.

---

## 11. INSERT, UPDATE and DELETE

### INSERT

Adds rows.

### UPDATE

Changes existing rows.

Always understand the WHERE clause before running an UPDATE.

### DELETE

Removes rows.

A DELETE without a WHERE clause can remove every row from the target table.

Production habit:

```sql
SELECT ...
WHERE <same condition>;
```

First inspect what will be affected. Then perform the change inside an appropriate transaction.

---

## 12. Subqueries

A subquery is a query used inside another query.

It can represent:

- a single value
- a list
- an existence check
- a derived table

Example:

```sql
SELECT name
FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM accounts
  WHERE balance > 100000
);
```

Mental model:

> First calculate the inner requirement, then use its result for the outer requirement.

---

## 13. CTEs

A Common Table Expression (CTE) gives a query a temporary named result.

```sql
WITH customer_totals AS (
  SELECT customer_id, SUM(amount) AS total
  FROM transactions
  GROUP BY customer_id
)
SELECT *
FROM customer_totals
WHERE total > 100000;
```

CTEs improve readability and can break a complicated problem into logical stages.

They are not automatically faster than every alternative. Performance depends on the query and PostgreSQL planner behavior.

---

## 14. Recursive CTEs

A recursive CTE repeatedly applies a relationship until the required rows are produced.

Useful for:

- organizational hierarchies
- category trees
- folder structures
- graph-like relationships

Conceptually:

```text
anchor rows
   ↓
find children
   ↓
find next level
   ↓
repeat
```

Always consider cycle prevention and maximum depth for production hierarchies.

---

## 15. Window Functions

A window function calculates across related rows while keeping individual rows visible.

Example:

```sql
SELECT account_id,
       transaction_date,
       amount,
       SUM(amount) OVER (
         PARTITION BY account_id
         ORDER BY transaction_date
       ) AS running_total
FROM transactions;
```

Aggregation normally collapses rows.

Window functions normally **do not collapse rows**.

Common uses:

- ranking
- running totals
- moving averages
- previous/next row comparison
- top-N per group

Important functions include:

```text
ROW_NUMBER()
RANK()
DENSE_RANK()
LAG()
LEAD()
SUM() OVER (...)
AVG() OVER (...)
```

---

## 16. CASE Expressions

CASE implements conditional logic inside SQL.

```sql
SELECT account_number,
       CASE
         WHEN balance < 0 THEN 'OVERDRAWN'
         WHEN balance = 0 THEN 'ZERO'
         ELSE 'ACTIVE'
       END AS status
FROM accounts;
```

Think:

> If condition A, return result A; otherwise test the next condition.

CASE is useful for classification, reporting, and controlled business rules.

---

## 17. Views

A view is a stored query definition that can be queried like a table.

Views can:

- simplify complex queries
- expose selected columns
- provide a stable reporting interface
- help enforce access boundaries

A normal view does not generally store a separate copy of the result.

---

## 18. Materialized Views

A materialized view stores the query result.

This can make repeated analytical reads faster, but the stored result can become stale.

Therefore every materialized-view design needs a refresh strategy.

Mental model:

**View = reusable definition.**

**Materialized view = stored result that must be refreshed.**

---

## 19. Functions and Procedures

Database functions encapsulate reusable logic and can return values or result sets.

Procedures are designed for callable database operations and transaction-oriented workflows.

Use database-side logic deliberately. Keep business logic in the database when it provides a clear consistency, data locality, security, or operational benefit.

---

## 20. Triggers

A trigger automatically executes a function when a specified database event occurs.

Typical uses:

- audit records
- derived values
- enforcement of specialized rules

Risks:

- hidden side effects
- unexpected performance costs
- difficult debugging

Production systems should keep trigger behavior simple and documented.

---

## 21. Transactions

A transaction groups related operations into one logical unit.

Example:

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

COMMIT;
```

If something goes wrong:

```sql
ROLLBACK;
```

Mental model:

> Either the logical operation succeeds as a unit, or the database returns to the earlier consistent state.

---

## 22. ACID

ACID describes important transaction guarantees.

### Atomicity
All required changes happen, or none do.

### Consistency
Transactions preserve defined database rules and constraints.

### Isolation
Concurrent transactions should not improperly interfere with each other.

### Durability
Committed data survives the failures covered by the database's durability guarantees.

ACID is about transaction behavior, not simply whether a database is relational.

---

## 23. Concurrency and Locks

Multiple users can access the same data simultaneously.

Locks and MVCC help PostgreSQL coordinate concurrent work.

A transaction may:

- read data
- update data
- wait for another transaction
- block another transaction
- deadlock with another transaction

A **deadlock** occurs when transactions wait for each other in a cycle.

Production design should keep transactions short and acquire shared resources in a consistent order where practical.

---

## 24. Isolation Levels

Isolation levels define how concurrent transactions observe data.

Common PostgreSQL levels include:

- Read Committed
- Repeatable Read
- Serializable

Higher isolation can provide stronger guarantees but may increase contention, retries, or serialization failures.

Choose isolation based on the correctness requirement, not simply because "higher is better."

---

## 25. Index Theory

An index is a data structure that can help the database find rows without scanning every row.

Example:

```sql
CREATE INDEX idx_customers_email
ON customers(email);
```

Indexes can improve reads, but they also have costs:

- storage
- write overhead
- maintenance
- memory/cache usage
- planning complexity

Do not create an index just because a column exists.

Design indexes around real query patterns.

---

## 26. Composite Indexes

A composite index contains multiple columns.

```sql
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);
```

Column order matters.

The best order depends on predicates, sorting, selectivity, and workload.

A composite index is not simply "two indexes in one."

---

## 27. EXPLAIN and Query Plans

The PostgreSQL optimizer chooses a plan to execute a query.

Use:

```sql
EXPLAIN
SELECT ...
```

or:

```sql
EXPLAIN ANALYZE
SELECT ...
```

Important concepts:

- sequential scan
- index scan
- bitmap scan
- nested loop
- hash join
- merge join
- sort
- aggregate
- estimated rows
- actual rows
- execution time

The goal is not to memorize plan names. The goal is to understand **why the planner chose the path and whether the observed work matches expectations**.

---

## 28. Query Performance Method

A production performance investigation should follow evidence.

1. Identify the slow operation.
2. Capture the exact query and parameters.
3. Check execution plan.
4. Compare estimated and actual rows.
5. Check indexes and statistics.
6. Check blocking and locks.
7. Check data volume and skew.
8. Test a controlled improvement.
9. Measure again.
10. Document the root cause.

Do not optimize by guessing.

---

## 29. Partitioning

Partitioning divides a large logical table into smaller physical pieces.

Common strategy:

- range partitioning
- list partitioning
- hash partitioning

Partitioning can help with large time-series or naturally segmented data.

It adds operational complexity, so it should be introduced when the workload benefits from it.

---

## 30. JSON and JSONB

PostgreSQL supports structured JSON data.

JSON is useful when the data shape is genuinely semi-structured.

JSONB stores data in a binary representation optimized for processing and indexing.

Do not automatically put every relational field into JSON. Relational columns and constraints are often better when the structure is known and important.

---

## 31. UPSERT and MERGE

An UPSERT handles "insert if new, otherwise update" behavior.

PostgreSQL commonly uses:

```sql
INSERT INTO customers(customer_id, name)
VALUES (1, 'Ravi')
ON CONFLICT (customer_id)
DO UPDATE SET name = EXCLUDED.name;
```

This is useful for idempotent ingestion and synchronization.

MERGE supports conditional insert/update/delete behavior based on source and target matching.

---

## 32. Data Quality

A production database should protect against:

- duplicates
- orphan records
- invalid ranges
- unexpected NULLs
- invalid status values
- broken references

Use a combination of:

- constraints
- validation queries
- unique indexes
- foreign keys
- monitoring
- controlled ingestion

Data quality is not only an application concern.

---

## 33. Idempotency

An operation is idempotent when repeating it produces the same intended final state.

This is extremely important in integrations and data pipelines.

Example:

If a message with external ID `TXN-1001` arrives twice, the system should not create two financial transactions.

A unique business key can help enforce this.

---

## 34. Security Theory

Database security has several layers:

1. authentication — who are you?
2. authorization — what may you do?
3. object permissions — which tables/functions may you access?
4. row-level security — which rows may you see?
5. least privilege — give only required permissions.
6. auditing — record important security-sensitive actions.

Never put real production passwords in learning SQL files.

---

## 35. Row-Level Security

Row-Level Security (RLS) controls which rows a role can access.

It is useful for multi-tenant or data-isolation requirements.

Mental model:

> Table permission answers "can this role use the table?" RLS can additionally answer "which rows can this role see or change?"

---

## 36. Full-Text Search

Full-text search is designed for searching natural-language documents more intelligently than simple wildcard matching.

Core ideas include:

- document normalization
- tokenization
- lexemes
- text search vectors
- text search queries
- relevance ranking
- indexes

Use it when the requirement is actual document search rather than simple prefix or exact matching.

---

## 37. LATERAL

LATERAL allows a subquery in the FROM clause to reference columns from preceding FROM items.

This is useful for:

- top-N related rows
- per-row calculations
- expanding nested data
- selecting the latest related record

Mental model:

> Run this related query with the current left-side row as input.

---

## 38. Recursive and Graph Thinking

SQL can represent hierarchical and graph-like relationships, but recursion requires careful boundaries.

Always think about:

- starting nodes
- relationships
- termination
- cycles
- depth
- duplicate paths

A query that works on ten rows can behave very differently on millions of connected records.

---

## 39. Auditability

Critical systems often need to answer:

- who changed the data?
- what changed?
- when?
- from what value?
- to what value?
- why was the change allowed?

Audit design can use dedicated audit tables, triggers, application events, or a combination.

Audit data itself should be protected and retained according to organizational requirements.

---

## 40. OLTP vs OLAP

### OLTP

Online Transaction Processing focuses on operational workloads:

- many short transactions
- frequent inserts/updates
- strong consistency
- point lookups

Examples: banking, order processing, customer accounts.

### OLAP

Online Analytical Processing focuses on analysis:

- large scans
- aggregations
- reporting
- historical analysis

Examples: dashboards, business intelligence, analytics.

The data model and indexing strategy may differ substantially.

---

## 41. SQL and Application Architecture

SQL is one part of a larger system.

A production flow may look like:

```text
Client
  ↓
API / Application
  ↓
Service logic
  ↓
Database
  ↓
Indexes / storage / WAL
```

A slow API may be caused by:

- inefficient SQL
- missing indexes
- lock contention
- connection pool exhaustion
- network latency
- application serialization
- excessive result sizes

Database troubleshooting should therefore consider the whole transaction path.

---

## 42. Connection Pooling

Opening a new database connection for every request can be expensive.

Connection pools reuse established connections.

Important operational concepts:

- pool size
- connection timeout
- idle timeout
- maximum lifetime
- database connection limits
- application concurrency

Too many application instances with large pools can exhaust database connections.

---

## 43. WAL and Durability

PostgreSQL uses Write-Ahead Logging (WAL).

The core idea is:

> Required change information is recorded in the log before the corresponding data page changes are considered safely persisted according to the database's durability process.

WAL supports recovery and replication mechanisms.

You do not need to memorize internals at beginner level, but production engineers should understand that durability, recovery, replication, and backups are connected to WAL.

---

## 44. Backups and Recovery

A backup is useful only if it can actually be restored.

Understand:

- logical backups
- physical backups
- point-in-time recovery
- restore testing
- recovery objectives
- retention

Two important business concepts:

**RPO (Recovery Point Objective)** — how much data loss is acceptable.

**RTO (Recovery Time Objective)** — how quickly service should be restored.

---

## 45. Replication

Replication copies database changes to another database server or environment.

Common reasons:

- high availability
- read scaling
- disaster recovery
- reporting

Replication is not automatically a backup. A bad DELETE can be replicated too.

---

## 46. Statistics and the Query Planner

The planner needs information about data distribution.

Statistics help estimate:

- number of rows
- value distribution
- selectivity

Bad estimates can produce poor plans.

This is why statistics maintenance and representative data matter when investigating performance.

---

## 47. Common SQL Anti-Patterns

Avoid these patterns unless there is a deliberate reason:

- SELECT * in stable production interfaces
- UPDATE without first checking the target rows
- DELETE without a controlled predicate
- functions on indexed columns that prevent useful index access
- unnecessary DISTINCT used to hide duplicate-producing joins
- huge transactions
- unbounded recursive queries
- indexes created without workload evidence
- storing structured relational data entirely as JSON
- relying only on application validation for critical integrity rules

---

## 48. Production SQL Troubleshooting

When an incident occurs, ask:

### Correctness
Is the query returning the correct data?

### Performance
Is it doing more work than expected?

### Concurrency
Is it waiting on another transaction?

### Capacity
Are CPU, memory, storage, I/O, or connections constrained?

### Data
Did data volume or distribution change?

### Deployment
Did the query, schema, index, or application change recently?

### Security
Does the executing role still have the required permissions?

A good SQL engineer investigates evidence rather than guessing.

---

## 49. How to Read Any SQL Query

When you see an unfamiliar query, break it down:

1. What tables are involved?
2. What relationship connects them?
3. Which rows are filtered?
4. Are rows grouped?
5. Are groups filtered?
6. Are calculations performed?
7. Is there a window?
8. Is there a subquery or CTE?
9. Can NULL change the result?
10. Can duplicates multiply rows?
11. What indexes could help?
12. What happens under concurrency?
13. What permissions are required?

This checklist is useful for interviews and production support.

---

## 50. Learning Method

For every SQL concept in this repository:

1. Read the theory.
2. Draw the data relationship mentally.
3. Read the example.
4. Explain the query in your own words.
5. Run it.
6. Compare the result with your expectation.
7. Change one condition.
8. Predict the new result before running it.
9. Solve the exercise without copying.
10. Explain the real-world use case.

**The goal is understanding, not memorization.**

---

## 51. Suggested Progression

```text
SQL basics
   ↓
Relational thinking
   ↓
Filtering and joins
   ↓
Aggregation
   ↓
Subqueries and CTEs
   ↓
Window functions
   ↓
Keys and normalization
   ↓
Transactions and concurrency
   ↓
Indexes and query plans
   ↓
Security
   ↓
Advanced PostgreSQL
   ↓
Data engineering
   ↓
Production troubleshooting
   ↓
Real-world projects
```

Use the SQL files for hands-on practice, and use this document plus each folder's README for the **why and how** behind the commands.
