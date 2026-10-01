# 04 — Database Design

Good SQL starts with good data modeling.

## What is database design?
It decides what information exists, how it is represented, and how records relate.

Banking example: Customer → Account → Transaction. One customer can own multiple accounts; one account can have many transactions.

## Primary key
Uniquely identifies a row.
```sql
customer_id BIGINT PRIMARY KEY
```

## Foreign key
Connects one table to another.
```sql
customer_id BIGINT REFERENCES customers(customer_id)
```

## Constraints
NOT NULL means required. UNIQUE prevents duplicates. CHECK enforces a condition. PRIMARY KEY identifies a row. FOREIGN KEY protects relationships.

## Normalization
Normalization reduces unnecessary duplication. Customer information belongs in the customer table rather than being repeated on every transaction.

## Denormalization
Reporting systems may intentionally precompute or duplicate data for faster reads. That is a trade-off and creates synchronization responsibility.
