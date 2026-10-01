# SQL From Zero to Advanced 🚀

Welcome to a practical SQL learning journey.

This repository is designed for someone who may be completely new to SQL. **Do not read the queries as magic syntax.** Each lesson should first explain what problem we are solving, what the database is doing, why the syntax is written that way, and what result to expect.

## How every lesson works

For each concept, follow this order:

1. **What is it?** — plain-English definition.
2. **Why do we need it?** — the real problem it solves.
3. **Mental model** — how to think about it before writing SQL.
4. **Syntax** — the general pattern.
5. **Example** — a small runnable query.
6. **Line-by-line explanation** — what each important part does.
7. **Expected result** — what the learner should observe.
8. **Practice** — a small task without the answer immediately visible.
9. **Challenge** — a realistic problem.
10. **Real-world use** — where professionals use the concept.
11. **Common mistakes** — what beginners frequently get wrong.
12. **Interview questions** — reinforce understanding.

## Learning path

| Stage | What you learn |
|---|---|
| 00 | Install PostgreSQL and understand the environment |
| 01 | SQL foundations and CRUD |
| 02 | Joins, aggregation, subqueries and business logic |
| 03 | CTEs, recursion, windows, views, functions and triggers |
| 04 | Database design, keys, constraints and normalization |
| 05 | Transactions, ACID, locks and isolation |
| 06 | Indexes, execution plans and performance |
| 07 | Roles, permissions and database security |
| 08 | Complete banking database |
| 09 | Production troubleshooting scenarios |
| 10 | Interview preparation |
| 11 | Expert PostgreSQL |
| 12 | Data engineering and analytics |
| 13 | Real-world projects |

## Important

SQL is not about memorizing commands. Learn to answer these questions:

- What data do I need?
- Where does that data live?
- How are the tables related?
- Which rows should be included?
- How should the result be grouped?
- What business rule am I implementing?
- Is the query correct with NULLs?
- Will it perform well with millions of rows?
- What happens if two users execute it at the same time?
- What permissions should the operation have?

## UI

The `web/` folder contains a local-first learning interface. It requires **no API keys, no paid services, and no external authentication provider** for the learner demo.

## Start

Begin with [00-installation](00-installation/README.md), then progress in order.