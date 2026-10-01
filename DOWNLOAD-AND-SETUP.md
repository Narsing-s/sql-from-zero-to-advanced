# Download & Setup Guide

## Goal

Install PostgreSQL, choose a SQL client, connect safely, download this repository, and run your first SQL scripts.

> This course is PostgreSQL-focused. You do not need an API key, paid service, cloud account, external email provider, or external authentication provider.

## 1. Choose your setup

| Setup | Best for |
|---|---|
| Windows + PostgreSQL + pgAdmin | Beginners |
| PostgreSQL + psql | Terminal practice |
| macOS + PostgreSQL | macOS learners |
| Linux + PostgreSQL | Linux learners |
| Docker + PostgreSQL | Developers and repeatable environments |

## 2. Download PostgreSQL

### Windows

1. Open the official PostgreSQL Windows page.
2. Download the installer.
3. Install PostgreSQL Server and Command Line Tools.
4. Install pgAdmin if you want a graphical interface.
5. Set and remember your local PostgreSQL password.
6. Keep the default port unless you already need another port.

Official download:
https://www.postgresql.org/download/windows/

### macOS

Use the official PostgreSQL macOS download/instructions:

https://www.postgresql.org/download/macosx/

### Linux

Use the official PostgreSQL instructions for your Linux distribution:

https://www.postgresql.org/download/linux/

### Docker (optional)

Docker is optional; PostgreSQL itself is enough for this course.

Docker:
https://www.docker.com/

Official PostgreSQL image:
https://hub.docker.com/_/postgres

## 3. Verify PostgreSQL

Open PowerShell, Command Prompt, Terminal, or your shell:

```bash
psql --version
```

Connect:

```bash
psql -U postgres
```

For an explicit host/port:

```bash
psql -U postgres -h localhost -p 5432
```

## 4. Create the learning database

Inside `psql`:

```sql
CREATE DATABASE sql_learning;
```

Connect:

```text
\\c sql_learning
```

Verify:

```sql
SELECT current_database(), current_user, version();
```

## 5. Download this repository

### Option A — Clone with Git

Download Git:
https://git-scm.com/downloads

Then:

```bash
git clone https://github.com/Narsing-s/sql-from-zero-to-advanced.git
cd sql-from-zero-to-advanced
```

### Option B — Download ZIP

If you are new to Git:

1. Open the repository.
2. Click **Code**.
3. Click **Download ZIP**.
4. Extract the ZIP.
5. Open the extracted `sql-from-zero-to-advanced` folder.

Repository:
https://github.com/Narsing-s/sql-from-zero-to-advanced

## 6. Run the first SQL scripts

From the repository root:

```bash
psql -U postgres -d sql_learning -f 00-installation/postgresql-setup.sql
psql -U postgres -d sql_learning -f 00-installation/verification.sql
```

Or connect first:

```bash
psql -U postgres -d sql_learning
```

Then:

```text
\\i 00-installation/postgresql-setup.sql
\\i 00-installation/verification.sql
```

If your terminal is not in the repository folder, use the full file path.

## 7. GUI method with pgAdmin

1. Open pgAdmin.
2. Connect to your local PostgreSQL server.
3. Select the `sql_learning` database.
4. Open **Query Tool**.
5. Open `00-installation/postgresql-setup.sql`.
6. Execute it.
7. Open `verification.sql`.
8. Execute it.
9. Confirm the database, user, and PostgreSQL version.

pgAdmin download:
https://www.pgadmin.org/download/

## 8. Optional VS Code setup

VS Code is useful for reading and editing SQL.

Download:
https://code.visualstudio.com/download

Use psql or pgAdmin to execute scripts.

## 9. Optional web learning UI

The `web/` folder contains a local-first learner interface.

Install Node.js:
https://nodejs.org/en/download

Run:

```bash
cd web
npm install
npm run dev
```

Open:

```text
http://localhost:3000
```

The UI does not require API keys or external services.

## 10. Recommended learning process

```text
Download PostgreSQL
        ↓
Install PostgreSQL + optional pgAdmin
        ↓
Verify psql
        ↓
Create sql_learning
        ↓
Download/clone this repository
        ↓
Run installation scripts
        ↓
Read theory
        ↓
Run examples
        ↓
Predict results
        ↓
Practice without copying
        ↓
Solve real-world scenarios
        ↓
Study performance + security
        ↓
Build projects
        ↓
Prepare for interviews
```

## 11. Common problems

### `psql is not recognized`

Use the PostgreSQL SQL Shell, or add PostgreSQL's `bin` directory to your PATH.

### Password authentication failed

Check the PostgreSQL username and password created during installation.

Never commit database passwords to Git.

### Connection refused

Check that PostgreSQL is running and that the host and port are correct.

### Wrong database

Before destructive SQL, run:

```sql
SELECT current_database(), current_user;
```

## 12. Safety rule

For learning, use the dedicated `sql_learning` database.

Before running SQL, identify whether it:
- reads data;
- inserts data;
- updates data;
- deletes data;
- changes schema;
- drops objects.

Never experiment against a production database.

## 13. Minimum downloads

**Required:** PostgreSQL

**Recommended:** PostgreSQL + pgAdmin + Git

**Optional:** VS Code + Docker + the `web/` learner UI

## 14. Continue learning

1. [Complete SQL Theory](COMPLETE-SQL-THEORY.md)
2. [Core Concepts](CORE-CONCEPTS.md)
3. [Beginner SQL](01-beginner/README.md)
4. [Installation](00-installation/README.md)
5. Continue through folders `02` → `13`.

The goal is not merely to memorize SQL commands. Learn the theory, relational semantics, correctness, execution, performance, concurrency, security, and production practices behind them.
