# 🛠️ SQL From Zero to Advanced — Installation Guide

> **Start here if you are new to SQL.** This guide takes you from a fresh computer to a working PostgreSQL learning environment.

## 1. What are we installing?

This repository uses **PostgreSQL** as the reference database.

You will learn:

- PostgreSQL Server — stores and processes your databases
- Database — an isolated collection of database objects
- Schema — a namespace inside a database
- Table — stores rows and columns
- `psql` — PostgreSQL command-line client
- pgAdmin — optional graphical PostgreSQL client
- Git — optional but recommended for downloading/updating this repository

### Mental model

```text
Computer
  ↓
PostgreSQL Server
  ↓
Database: sql_learning
  ↓
Schema: learning
  ↓
Tables
  ↓
Rows → Columns → Values
```

---

## 2. Requirements

### Minimum

- PostgreSQL
- A terminal or SQL client
- This repository

### Recommended

- PostgreSQL
- pgAdmin
- Git
- VS Code

### Optional

- Docker
- SQL Learning Hub web UI

No API key, paid service, cloud database, external authentication, or email provider is required.

---

## 3. Windows — recommended beginner setup

### Step 1 — Download PostgreSQL

Use the official PostgreSQL Windows download page:

https://www.postgresql.org/download/windows/

Download the installer and start it.

### Step 2 — Install

During installation:

1. Install PostgreSQL Server.
2. Keep Command Line Tools selected.
3. Install pgAdmin if offered.
4. Set a password for the PostgreSQL `postgres` user.
5. Remember this password.
6. Keep port **5432** unless you have a reason to change it.
7. Finish the installation.

### Step 3 — Verify

Open PowerShell or Command Prompt:

```powershell
psql --version
```

If it works, you should see a PostgreSQL client version.

If Windows says `psql is not recognized`, use the installed **SQL Shell (psql)** or add PostgreSQL's `bin` directory to PATH.

---

## 4. macOS

Official instructions:

https://www.postgresql.org/download/macosx/

After installation:

```bash
psql --version
```

Then connect:

```bash
psql -U postgres
```

---

## 5. Linux

Use the official PostgreSQL instructions for your distribution:

https://www.postgresql.org/download/linux/

Then verify:

```bash
psql --version
```

---

## 6. Optional Docker installation

Docker is not required.

If you prefer containers:

https://www.docker.com/

Official PostgreSQL image:

https://hub.docker.com/_/postgres

Make sure the container exposes the PostgreSQL port you intend to use before following the connection commands below.

---

## 7. Create the learning database

Connect as the PostgreSQL administrator:

```bash
psql -U postgres
```

Create a dedicated learning database:

```sql
CREATE DATABASE sql_learning;
```

Connect to it:

```text
\\c sql_learning
```

Verify:

```sql
SELECT current_database();
SELECT current_user;
SELECT version();
```

Expected idea:

```text
database = sql_learning
user     = the PostgreSQL user you connected with
version  = your PostgreSQL server version
```

---

## 8. Download this repository

### Option A — Git clone

Install Git:

https://git-scm.com/downloads

Clone:

```bash
git clone https://github.com/Narsing-s/sql-from-zero-to-advanced.git
cd sql-from-zero-to-advanced
```

### Option B — GitHub ZIP

Open:

https://github.com/Narsing-s/sql-from-zero-to-advanced

Then:

```text
Code
 ↓
Download ZIP
 ↓
Extract ZIP
 ↓
Open sql-from-zero-to-advanced
```

Git is recommended because you can later update the repository with:

```bash
git pull
```

---

## 9. Run the repository installation scripts

Make sure your terminal is in the repository root.

### First setup

```bash
psql -U postgres -d sql_learning -f 00-installation/postgresql-setup.sql
```

### Verify

```bash
psql -U postgres -d sql_learning -f 00-installation/verification.sql
```

These scripts create the learning schema/table and verify the environment.

---

## 10. Run through psql instead

Connect:

```bash
psql -U postgres -d sql_learning
```

Then:

```text
\\i 00-installation/postgresql-setup.sql
\\i 00-installation/verification.sql
```

If the file cannot be found, your current directory is probably not the repository root. Use an absolute path.

---

## 11. Run through pgAdmin

Download pgAdmin:

https://www.pgadmin.org/download/

Process:

```text
Open pgAdmin
  ↓
Connect to PostgreSQL
  ↓
Open sql_learning
  ↓
Open Query Tool
  ↓
Open postgresql-setup.sql
  ↓
Execute
  ↓
Open verification.sql
  ↓
Execute
  ↓
Confirm results
```

---

## 12. First successful verification

Run:

```sql
SELECT current_database();
SELECT current_user;
SELECT version();
SELECT * FROM learning.installation_check ORDER BY id DESC;
```

If these execute successfully, your learning environment is ready.

---

## 13. Optional VS Code

Download:

https://code.visualstudio.com/download

Open the repository folder in VS Code.

Use pgAdmin or `psql` as your execution client. An editor and a database server are different things:

```text
VS Code = write/read SQL
       ↓
psql / pgAdmin = send SQL
       ↓
PostgreSQL = execute SQL
       ↓
Result
```

---

## 14. Optional SQL Learning Hub UI

The `web/` directory contains a local learner interface.

Install Node.js:

https://nodejs.org/en/download

Then:

```bash
cd web
npm install
npm run dev
```

Open:

```text
http://localhost:3000
```

The UI provides lesson navigation, theory links, SQL material links and browser-local progress.

It does not require API keys or external services.

---

## 15. Recommended learning process

Do not immediately memorize queries.

Use this process:

```text
Definition
   ↓
Purpose
   ↓
Mental Model
   ↓
Syntax
   ↓
Example
   ↓
Line-by-Line Explanation
   ↓
Expected Result
   ↓
Practice
   ↓
Edge Cases
   ↓
Common Mistakes
   ↓
Performance
   ↓
Security
   ↓
Concurrency
   ↓
Production Use
   ↓
Interview Questions
```

---

## 16. Start the course

After installation:

1. Read [Complete SQL Theory](COMPLETE-SQL-THEORY.md).
2. Use [Core Concepts](CORE-CONCEPTS.md) as your glossary.
3. Start [01 — Beginner SQL](01-beginner/README.md).
4. Run the accompanying SQL files.
5. Complete exercises.
6. Continue through intermediate and advanced material.
7. Build the banking project.
8. Study production scenarios.
9. Study expert PostgreSQL.
10. Build real-world projects.

---

## 17. Common problems

### Problem: `psql is not recognized`

Use SQL Shell (psql), or add PostgreSQL's `bin` directory to PATH.

### Problem: password authentication failed

Check the username/password created during PostgreSQL installation.

Do not commit passwords to Git.

### Problem: connection refused

Check that PostgreSQL Server is running and that you are using the correct host and port.

### Problem: port 5432 already in use

Find which PostgreSQL instance is using the port, or connect to the port of the intended instance.

### Problem: wrong database

Always verify:

```sql
SELECT current_database(), current_user;
```

### Problem: SQL file not found

Check your current directory:

```bash
pwd
```

On Windows PowerShell:

```powershell
Get-Location
```

Then move to the repository root before running the script.

### Problem: permission denied

Make sure the connected PostgreSQL user has the required permissions.

---

## 18. Safety rules

For learning:

- use `sql_learning`;
- read a destructive statement before executing it;
- understand `DROP`, `DELETE`, `TRUNCATE`, and `UPDATE`;
- never test destructive SQL against production;
- never commit passwords, tokens, connection strings, or private credentials.

Before dangerous operations, confirm:

```sql
SELECT current_database(), current_user;
```

---

## 19. Installation checklist

- [ ] PostgreSQL installed
- [ ] PostgreSQL server running
- [ ] `psql --version` works
- [ ] PostgreSQL credentials known
- [ ] `sql_learning` database created
- [ ] Repository downloaded/cloned
- [ ] `postgresql-setup.sql` executed
- [ ] `verification.sql` executed
- [ ] `learning.installation_check` verified
- [ ] Theory opened
- [ ] Beginner lessons started

## 20. You are ready

Your environment is ready when:

```text
PostgreSQL
    +
sql_learning
    +
Repository
    +
Working psql/pgAdmin
    ↓
Ready to learn SQL
```

**Next:** [Complete SQL Theory](COMPLETE-SQL-THEORY.md) → [Beginner SQL](01-beginner/README.md)
