# SQL 101 Practice Track

Original exercises following a beginner-to-intermediate SQL learning progression.

## How to use
1. Read the requirement.
2. Write SQL without looking at a solution.
3. Predict the result.
4. Run it against the learning database.
5. Explain why it works.
6. Test a NULL, duplicate, empty-result, or boundary case where applicable.

## Stage 1 — Fundamentals
1. List all customers.
2. Return only customer names and emails.
3. Find customers from a selected city.
4. Sort customers by creation date, newest first.
5. Return the first five customers.
6. Find customers whose email is missing.
7. Insert a new customer.
8. Safely update one customer's email.
9. Safely delete a test customer.
10. Create a table with primary key, NOT NULL, UNIQUE and CHECK constraints.

## Stage 2 — Relationships and joins
11. List customers with their accounts.
12. Find customers who do not have an account.
13. Return every account and its customer when available.
14. Demonstrate INNER JOIN and LEFT JOIN on the same data.
15. Model a many-to-many relationship with a bridge table.
16. Find customers with more than one related account.

## Stage 3 — Aggregation
17. Count customers.
18. Count accounts per customer.
19. Calculate total account balance.
20. Calculate average balance by account type.
21. Find account types whose total balance exceeds a threshold.
22. Return minimum and maximum balance.
23. Explain WHERE versus HAVING with a query.

## Stage 4 — Subqueries and reusable queries
24. Find customers whose balance is above the overall average.
25. Find customers who have at least one account using EXISTS.
26. Find customers who have no account using NOT EXISTS.
27. Build a reusable view for customer/account reporting.
28. Rewrite one subquery using a JOIN and compare readability.

## Stage 5 — Transactions and performance
29. Transfer money between two accounts atomically.
30. Create an index for a frequently filtered column and inspect EXPLAIN.
31. Demonstrate COMMIT and ROLLBACK.
32. Explain a deadlock caused by inconsistent update order.
33. Identify a query that scans too many rows and propose a measurable improvement.

## Stage 6 — Advanced SQL
34. Calculate a running transaction total with a window function.
35. Return the latest transaction for every account.
36. Build a CTE that summarizes customer activity.
37. Build a recursive CTE for a hierarchy.
38. Create a reusable database function.
39. Create a trigger that records an audit event.
40. Store and query a JSONB attribute.

## Stage 7 — Production scenarios
41. A retry creates duplicate business records. Design an idempotency strategy.
42. A query becomes slow after the table grows. Explain the investigation sequence.
43. Two transactions deadlock. Describe investigation and prevention.
44. A required field is unexpectedly NULL. Identify database and application controls.
45. A deployment changes a column used by an integration. Design a safer migration sequence.

## Self-check
- Can I explain the query in plain English?
- Can I predict its result?
- What happens with NULL?
- What happens with duplicate data?
- What happens with no matching rows?
- What happens when two sessions run it concurrently?
- What constraint or index would help?
- What would I monitor in production?

Attempt these before using EXERCISES-AND-SOLUTIONS.md, then continue through the staged curriculum and banking project.
