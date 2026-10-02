# Retryability Matrix

| SQLSTATE / condition | Typical meaning | Automatic retry? |
|---|---|---|
| 40001 | serialization failure | Usually yes, with bounded retry and idempotency |
| 40P01 | deadlock detected | Usually yes, with bounded retry and safe transaction design |
| 23505 | unique violation | Usually no; fix the conflicting business operation |
| 23503 | foreign-key violation | Usually no; correct ordering/data |
| 57014 | query canceled | Usually no; investigate timeout/cancellation source |
| connection/network failure | transaction outcome may be unknown | Requires idempotency and outcome verification |

A retry must not turn a non-idempotent operation into a duplicate business action.
