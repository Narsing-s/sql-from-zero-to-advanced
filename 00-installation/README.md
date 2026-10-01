# 00 — Installation

## Windows
Install PostgreSQL from the official PostgreSQL website, then install pgAdmin and optionally VS Code.

Verify from PowerShell:

```powershell
psql --version
```

Connect:

```powershell
psql -U postgres
```

Then create the training database:

```sql
CREATE DATABASE sql_learning;
```

Connect to it and run `postgresql-setup.sql`.

## Verify
Run `verification.sql`. You should see PostgreSQL version information and the sample table.
