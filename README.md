# SQL From Zero to Advanced 🚀

A free, hands-on SQL learning path from installation and beginner queries to advanced PostgreSQL, performance tuning, transactions, security, and a real-world banking database.

## 🎯 Goal
Learn SQL by **doing**, not memorizing. Every stage contains concepts, runnable SQL, exercises, solutions, and real-world scenarios.

## 🗺️ Roadmap
- 🟢 Beginner: database basics, tables, CRUD, SELECT, filtering, sorting, NULL
- 🟡 Intermediate: joins, aggregation, GROUP BY/HAVING, subqueries, CASE, dates and strings
- 🟠 Advanced: CTEs, recursive CTEs, window functions, views, functions, procedures, triggers
- 🔴 Database engineering: transactions, isolation, indexes, EXPLAIN ANALYZE, optimization, security
- 🏦 Project: complete banking database
- 💼 Interviews: practical and scenario-based questions
- 🤝 Contribution: exercises, fixes, explanations and translations welcome

## 🚀 Start Here
1. Read [Installation](00-installation/README.md)
2. Run [schema.sql](00-installation/postgresql-setup.sql)
3. Start [Beginner SQL](01-beginner/README.md)
4. Practice every exercise before checking solutions
5. Build the [Banking Project](08-banking-project/README.md)

## 🛠️ Stack
PostgreSQL • pgAdmin • VS Code • Docker • Git/GitHub

## 📚 Repository
| Section | Focus |
|---|---|
| 00-installation | PostgreSQL setup |
| 01-beginner | SQL fundamentals |
| 02-intermediate | Joins and analytical queries |
| 03-advanced | CTEs, windows, routines, triggers |
| 04-database-design | Keys, constraints, normalization |
| 05-transactions | ACID and concurrency |
| 06-performance | Indexes and query plans |
| 07-security | Roles and permissions |
| 08-banking-project | End-to-end project |
| 09-real-world-scenarios | Production troubleshooting |
| 10-interview-preparation | Interview practice |
| datasets | Practice data |
| docker | Containerized PostgreSQL |

## ⭐ Learning rule
Try every challenge yourself first. Then compare your solution with the answer and understand *why* it works.

If this helps you, star the repository and share it with another learner.

## 🧠 New Expert Curriculum
The repository now goes beyond CRUD into PostgreSQL engineering and analytics:
- NULL and three-valued logic
- LATERAL joins and DISTINCT ON
- FILTER and ordered aggregates
- JSON/JSONB and semi-structured data
- UPSERT and MERGE
- partitioning and pruning
- row-level security
- materialized views
- full-text search
- advisory locks
- data quality checks
- cohort/retention analysis
- incremental loading and watermarks
- real-world project architecture

See 11-expert-sql/README.md, 12-data-engineering/README.md, and 13-real-world-projects/README.md.

## 🖥️ SQL Learning Hub
A modern local-first learner UI is included under web/. It provides a demo login, progress tracking, lesson search, and a welcome-email hook. The demo does not store passwords.

### Optional real email
Set RESEND_API_KEY and EMAIL_FROM in the web app environment to enable a real welcome email through Resend. Never commit API keys or secrets to GitHub.

## 🌱 Help More Learners
Use the UI as the front door, then send learners back to the repository for runnable SQL. Contributions are welcome for new lessons, datasets, challenges, translations, tests, and real-world projects.
