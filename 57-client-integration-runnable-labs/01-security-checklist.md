# Client Integration Security Checklist

- [ ] Connection string supplied through environment/secret manager
- [ ] No password committed to source
- [ ] SQL parameters are bound, not string-concatenated
- [ ] Connection timeout configured
- [ ] Query/statement timeout configured where supported
- [ ] Transactions have explicit commit/rollback behavior
- [ ] Connections/cursors are closed
- [ ] Retry logic is limited to transient failures
- [ ] Retries are safe for the operation's idempotency semantics
- [ ] Logs do not expose credentials or sensitive query parameters