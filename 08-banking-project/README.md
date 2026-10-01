# 08 — End-to-End Banking SQL Project

## Goal
Combine SQL theory into one realistic relational system.

## Domain
Customers → Branches → Accounts → Transactions → Loans → Payments → Audit Logs

## Features
- customer registration
- account management
- deposits and withdrawals
- transfers
- balance reporting
- loans and payments
- audit history
- duplicate detection
- performance troubleshooting

## Build order
1. Read the business model.
2. Run schema.sql.
3. Run seed.sql.
4. Inspect relationships and constraints.
5. Run reports.
6. Test transaction scenarios.
7. Review indexes and execution plans.
8. Review security and audit requirements.

## Production thinking
Correctness → Transaction boundary → Constraints → Concurrency → Performance → Security → Observability → Recovery

## Challenge
Add a business requirement without breaking existing integrity. Document the schema change and migration strategy.
