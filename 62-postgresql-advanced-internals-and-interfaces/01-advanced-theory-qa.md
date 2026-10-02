# Advanced PostgreSQL Internals & Interfaces — Theory Q&A

## 1. What is the PostgreSQL planner?
The planner/optimizer transforms a SQL query into an execution plan. It evaluates possible access paths, join strategies, ordering, aggregation, parallelism, and other choices using statistics and cost estimates.

## 2. What is the executor?
The executor runs the chosen plan and produces rows or performs modifications. A poor plan can therefore be caused by incorrect estimates even when execution itself is functioning correctly.

## 3. What is JIT compilation?
PostgreSQL can use LLVM-based just-in-time compilation to compile parts of query execution. It can reduce CPU overhead for suitable expensive queries, but compilation itself has a cost.

## 4. When can JIT hurt performance?
For short queries, compilation overhead can exceed the execution savings. JIT is therefore workload-dependent and should be evaluated with EXPLAIN ANALYZE rather than enabled blindly.

## 5. What should you inspect when evaluating JIT?
Compare execution time with JIT enabled and disabled, inspect the EXPLAIN JIT section, and consider CPU cost, query duration, row counts, and repeated workload behavior.

## 6. What are system catalogs?
System catalogs are PostgreSQL's internal metadata tables and views describing databases, relations, columns, indexes, functions, roles, dependencies, statistics, and other objects.

## 7. What is information_schema?
information_schema is a standardized set of views exposing metadata in a more portable SQL-oriented form.

## 8. information_schema vs pg_catalog?
Use information_schema when portability and standard metadata representation matter. Use PostgreSQL's pg_catalog when PostgreSQL-specific detail is required.

## 9. Why should applications avoid writing directly to system catalogs?
Catalogs are managed by PostgreSQL. Direct modification is unsupported and can corrupt database metadata. Use SQL DDL and documented APIs.

## 10. What is the frontend/backend protocol?
It is the wire protocol used between PostgreSQL clients and servers. It carries startup information, authentication, queries, parameters, results, errors, and transaction-related messages.

## 11. What is libpq?
libpq is PostgreSQL's C client library and a foundation for many client applications and drivers.

## 12. Why does connection behavior matter in production?
Connection establishment, authentication, TLS, pooling, timeouts, transaction state, and network failures directly affect application availability.

## 13. What are prepared statements at the protocol/client level?
They separate statement preparation from parameter execution. This can reduce repeated parse work and safely bind parameters, while PostgreSQL's plan-selection behavior still needs consideration.

## 14. What are large objects?
Large objects provide PostgreSQL-managed storage for data that may be inconvenient to keep directly in ordinary table columns. They have their own APIs and permission considerations.

## 15. When should large objects be considered carefully?
When backup, replication, lifecycle management, application access, and storage requirements are easier to manage with ordinary bytea or external object storage.

## 16. What is ECPG?
ECPG is PostgreSQL's embedded SQL interface for C programs. It allows SQL statements to be integrated into C applications through a preprocessing model.

## 17. What is a foreign data wrapper?
An FDW provides an interface for accessing foreign data sources through PostgreSQL. It can expose remote data as foreign tables.

## 18. Why can FDWs be slower than local tables?
Network latency, remote execution limitations, poor pushdown, remote statistics, serialization, and multiple round trips can dominate execution time.

## 19. What is predicate pushdown in an FDW?
It means PostgreSQL can send eligible filtering or other operations to the remote source instead of fetching unnecessary rows locally.

## 20. What should you inspect in an FDW plan?
Check EXPLAIN output, remote SQL where exposed, row estimates, actual rows, join/filter pushdown, network behavior, and remote-system performance.

## 21. What is TABLESAMPLE?
TABLESAMPLE requests a sample of rows/pages according to a sampling method. It is useful for approximate analysis and testing but should not be treated as an exact random subset without understanding the method.

## 22. What is a custom scan provider?
It is an extension mechanism allowing PostgreSQL extensions to provide custom scan planning/execution behavior.

## 23. What is a table access method?
It is an extension interface for implementing alternative storage/access behavior for tables.

## 24. Why are custom scan and table access methods advanced topics?
They operate close to PostgreSQL internals and require careful compatibility, correctness, memory, concurrency, and performance engineering.

## 25. What is SPI?
The Server Programming Interface allows server-side code such as extensions and procedural-language implementations to execute SQL through PostgreSQL's internal interfaces.

## 26. What is the difference between a SQL function and an extension?
A SQL/PL function uses documented database-level functionality. An extension can package SQL objects and compiled code and can interact with deeper server interfaces.

## 27. What is SQL standard conformance?
It describes how closely PostgreSQL implements the ISO SQL standard. PostgreSQL supports a large portion of SQL while also providing PostgreSQL-specific extensions.

## 28. Why does portability matter?
SQL written against standard features is generally easier to move between database systems, while PostgreSQL-specific syntax may provide capabilities but increases migration effort.

## 29. What is a portability risk?
Examples include proprietary functions, PostgreSQL-specific operators/types, implicit casts, procedural languages, catalog queries, and dialect-specific DDL.

## 30. Should PostgreSQL applications avoid all extensions?
No. Extensions can provide valuable capabilities. The important questions are compatibility, operational ownership, upgrade support, backup/restore behavior, and portability requirements.

## 31. What is OAuth database authentication?
PostgreSQL 18 supports OAuth-based client authentication. The client obtains an access token and the server validates it through the configured OAuth integration.

## 32. What is an OAuth validator module?
It is server-side integration used to validate bearer tokens issued by an OAuth provider. A faulty validator can create an authentication security failure.

## 33. What is SCRAM?
SCRAM is a password authentication mechanism designed to avoid sending the password directly over the network and to provide stronger password authentication than older mechanisms.

## 34. Why is TLS still important with authentication?
Authentication and transport confidentiality solve different problems. TLS protects network traffic, while authentication verifies identity/credentials.

## 35. What is a connection startup packet?
It carries initial connection parameters such as user, database, and protocol information before normal query processing begins.

## 36. Why can DNS problems look like PostgreSQL problems?
The application may fail before reaching PostgreSQL. Connection troubleshooting must therefore separate DNS, TCP, TLS, authentication, pooling, and database-level failures.

## 37. What is the difference between logical query processing and physical execution?
Logical SQL describes the requested result. The optimizer chooses a physical strategy such as index scans, sequential scans, hash joins, merge joins, nested loops, and parallel operations.

## 38. Why can the same SQL have different plans?
Statistics, data distribution, PostgreSQL version, configuration, parameter values, available indexes, cost settings, and cache/environment conditions can change planning decisions.

## 39. What is a generic plan?
A reusable prepared-statement plan that is not tailored to a specific parameter value.

## 40. What is a custom plan?
A prepared-statement plan generated with knowledge of the current parameter values.

## 41. Why does parameter skew matter?
If different parameter values select radically different amounts of data, one generic plan may be inefficient for some values.

## 42. What is a catalog dependency?
PostgreSQL records relationships between objects such as tables, columns, functions, views, and types. Dependency information helps PostgreSQL enforce safe DDL behavior.

## 43. Why should production tooling prefer documented catalog views when possible?
They provide a stable, supported interface compared with assumptions about internal implementation details.

## 44. What is an execution-plan regression?
A query can return the same correct result while the optimizer chooses a significantly slower physical plan after a data, statistics, configuration, index, or version change.

## 45. How should an execution-plan regression be investigated?
Capture plans before and after, compare estimates versus actual rows, inspect statistics and indexes, identify the changed cost decision, and validate the fix under representative workload.

## 46. What is server-side protocol pipelining conceptually?
It allows clients to send multiple operations without waiting synchronously for each individual response, reducing round-trip latency when the client and operation pattern support it.

## 47. Why can network round trips dominate database latency?
A fast SQL operation repeated across many client/server exchanges can become slow because each exchange adds network and protocol overhead.

## 48. What is connection pooling?
A pool reuses established database connections so applications do not repeatedly pay connection/authentication overhead.

## 49. What is the danger of oversized connection pools?
Too many concurrent database sessions can increase memory, CPU, lock contention, context switching, and overall latency.

## 50. What is the key lesson from PostgreSQL's advanced interfaces?
Use the highest-level supported abstraction that satisfies the requirement. Move toward internal extension interfaces only when the operational and performance benefit justifies the complexity.
