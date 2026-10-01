# 04 — Database Design

## Goal
Design data structures that preserve correctness, reduce unnecessary duplication and support future queries.

## Mental model
Business requirement → Entities → Relationships → Keys → Constraints → Tables → Indexes

Banking example: Customer → Account → Transaction.

## Keys
- Primary key — uniquely identifies a row
- Foreign key — references a key in another table
- Candidate key — any valid unique identifier
- Natural key — meaningful business identifier
- Surrogate key — generated identifier

## Constraints
- NOT NULL — required value
- UNIQUE — prevents duplicates
- PRIMARY KEY — row identity
- FOREIGN KEY — relationship integrity
- CHECK — domain/business condition
- EXCLUDE — prevents conflicting values or ranges

## Normalization
Study 1NF → 2NF → 3NF → BCNF.

Normalization reduces unnecessary duplication and update anomalies. Controlled denormalization can help reporting and performance, but adds synchronization responsibility.

## Advanced design
- functional dependencies
- temporal data
- soft delete
- audit columns
- multi-tenancy
- hierarchical data
- retention
- polymorphic relationships

See BCNF-and-advanced-normalization.md.

## Design review
1. What is the table grain?
2. What identifies a row?
3. Which relationships exist?
4. Which values are mandatory?
5. Which rules must the database enforce?
6. What happens when referenced data is deleted?
7. Which queries are common?
8. Which indexes support them?

## Next
Continue to 05 — Transactions.
