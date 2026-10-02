# PostgreSQL Client Interfaces & SQL Conformance — 30 Production Scenarios

Use: **Impact → Scope → Evidence → Safe mitigation → Root cause → Permanent fix → Validation → Prevention.**

1. **A service runs out of memory on a large SELECT.**  
Inspect client result handling. Stream/chunk the result where supported instead of materializing millions of rows in application memory.

2. **A high-latency application sends thousands of tiny queries.**  
Measure network round trips and command count. Evaluate batching or pipeline mode where dependency and transaction semantics permit.

3. **Pipeline mode produces unexpected application errors.**  
Map each result to its originating command and verify error propagation/order handling rather than assuming all queued commands succeeded.

4. **A query timeout fires but the PostgreSQL backend keeps working briefly.**  
Inspect cancellation behavior, backend state and transaction cleanup. A client timeout does not guarantee instantaneous server termination.

5. **Users report intermittent connection failures after an upgrade.**  
Compare driver/libpq version, protocol negotiation, TLS, authentication and server logs across successful and failed connections.

6. **The application works with PostgreSQL 17 but not 18.**  
Build a compatibility matrix and compare driver/library versions, protocol settings, authentication and changed server features.

7. **OAuth authentication fails only in one environment.**  
Compare client OAuth parameters, server authentication configuration, validator configuration, token audience/issuer and authentication logs.

8. **A connection pool leaks session state between tenants.**  
Check transaction boundaries and session-level GUC/search_path/prepared-state behavior. Reset required session state before returning connections to the pool.

9. **A retry duplicates an INSERT.**  
Determine whether the original transaction committed before the client lost its response. Use a unique idempotency key and transactionally safe retry semantics.

10. **A COPY operation fails halfway through.**  
Capture the client/server error state, determine transaction outcome and restart from a defined checkpoint rather than blindly replaying the entire dataset.

11. **Client receives notices that trigger false alerts.**  
Separate notice handling from fatal-error handling and define severity-aware logging.

12. **Large-object data is inaccessible after a role migration.**  
Audit large-object privileges and ownership separately from table privileges.

13. **An ECPG application has intermittent data corruption.**  
Inspect host-variable types, memory lifetimes, error handling and transaction boundaries; reproduce with deterministic test data.

14. **Dynamic SQL in an ECPG service is vulnerable to injection.**  
Use parameterized/prepared execution and strict identifier handling; never concatenate untrusted values into SQL syntax.

15. **A portable metadata query fails on another database.**  
Replace PostgreSQL catalog dependencies with information_schema where the required metadata is standardized, then test semantics across engines.

16. **The team claims a query is SQL-standard because it runs on PostgreSQL.**  
Check the PostgreSQL SQL-conformance documentation and test the query against every supported engine/version.

17. **A PostgreSQL-specific feature is required by the product.**  
Document the portability boundary explicitly instead of hiding the dependency in generic repository code.

18. **A streaming client crashes while consuming a large result.**  
Make the transaction/cursor lifecycle explicit and ensure server resources are released after client failure.

19. **A connection is canceled but locks remain.**  
Inspect transaction state. Cancellation of a statement is not equivalent to closing/rolling back an application transaction.

20. **A pool reports healthy connections but requests fail.**  
Check server-side connection state, idle-in-transaction sessions, authentication expiry, network health and pool validation queries.

21. **Pipeline mode improves throughput but increases recovery complexity.**  
Benchmark against simpler batching and use pipelining only where the application's ordering/error semantics are well defined.

22. **A driver upgrade changes parameter behavior.**  
Compare prepared/parameterized execution, type inference and server logs. Add compatibility tests before rolling the driver fleet forward.

23. **TLS connections become slower after hardening.**  
Measure connection setup versus query latency. Reuse pooled connections and validate TLS configuration rather than weakening security blindly.

24. **The application retries after a network partition.**  
Determine whether the previous transaction outcome is known. If unknown, reconcile using an idempotency key or business transaction identifier before retrying.

25. **A large result causes database and application backpressure.**  
Limit result size, stream rows, apply pagination designed for the workload and control client concurrency.

26. **A client reports 'server closed the connection unexpectedly'.**  
Correlate client timestamps with server logs, OOM/restart events, network failures and backend termination evidence.

27. **Information_schema query becomes slow on a large database.**  
Inspect the generated plan and metadata scope. If PostgreSQL-specific high-volume introspection is required, compare with targeted system catalogs while preserving a documented portability boundary.

28. **Application behavior differs across PostgreSQL major versions.**  
Run the same compatibility suite, including SQL results, error handling, protocol/authentication behavior and performance-sensitive queries.

29. **A database driver upgrade passes unit tests but fails in production.**  
Add integration tests against the exact PostgreSQL major versions, TLS/auth modes, pooling configuration and transaction patterns used in production.

30. **Interviewer asks how to troubleshoot a PostgreSQL client incident.**  
Separate server SQL performance from client/network behavior; inspect connection lifecycle, protocol round trips, pooling, result consumption, cancellation, authentication, retries and transaction outcomes before changing SQL.
