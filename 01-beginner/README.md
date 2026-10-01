# 01 — Beginner SQL

## Goal
Understand what a database stores and write simple SQL without copying blindly.

## What is SQL?
SQL (Structured Query Language) is used to communicate with relational databases. A database stores related information in tables. A table contains columns (types of information) and rows (individual records).

Think of a customer table like a spreadsheet: column = customer_id/name/email; row = one customer; primary key = unique identity.

## SELECT — asking for data
SELECT means: “Database, give me this information.”

```sql
SELECT customer_id, name
FROM beginner.customers;
```
Read it as: “Give me customer IDs and names from the customers table.”

## WHERE — choosing rows
WHERE answers: “Which records do I want?”

```sql
SELECT customer_id, name
FROM beginner.customers
WHERE city = 'Hyderabad';
```
The database checks rows and keeps those whose city matches.

## ORDER BY — controlling order
```sql
SELECT name, created_at
FROM beginner.customers
ORDER BY created_at DESC;
```
DESC means newest/highest first; ASC means lowest/oldest first.

## INSERT — adding data
INSERT creates a row.
```sql
INSERT INTO beginner.customers(name, email)
VALUES ('Anita', 'anita@example.com');
```

## UPDATE — changing data
UPDATE changes rows matching its condition.
```sql
UPDATE beginner.customers
SET email = 'new@example.com'
WHERE customer_id = 1;
```
Always inspect the WHERE condition before UPDATE.

## DELETE — removing data
```sql
DELETE FROM beginner.customers
WHERE customer_id = 1;
```
The WHERE clause protects other rows.

## Practice method
Say each query in English first. Write SQL second. Predict the result third. Execute last.
