# Duplicate Data Exercise

Find duplicates:

```sql
SELECT email,COUNT(*) FROM bank.customers GROUP BY email HAVING COUNT(*)>1;
```

Design a cleanup strategy and explain why UNIQUE prevents recurrence.