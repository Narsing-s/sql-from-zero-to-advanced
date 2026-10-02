# PostgreSQL Server Tools & Deep Observability — 40 Theory Q&A

1. **What is pg_controldata?**  
It reports low-level control-file and cluster state information useful during startup, recovery and incident investigation.

2. **When is pg_controldata useful?**  
During recovery investigations, upgrade validation, timeline analysis and other cases where SQL-level evidence is insufficient.

3. **What does pg_checksums do?**  
It checks, enables or disables data-page checksums according to supported operational rules.

4. **Why are data checksums valuable?**  
They can detect certain classes of on-disk corruption before corrupted pages silently propagate through normal operations.

5. **What is pg_waldump?**  
A diagnostic utility that renders WAL records in human-readable form for low-level WAL investigation.

6. **What is pg_walsummary?**  
A utility for inspecting summarized WAL information, useful when investigating which data blocks may be represented in WAL summaries.

7. **Why should WAL utilities be treated as diagnostic tools?**  
They expose implementation-level evidence and should not be confused with normal SQL workload tools.

8. **What is pg_rewind?**  
A utility for bringing a divergent PostgreSQL data directory back in sync with another timeline after suitable failover/fork scenarios.

9. **Why is pg_rewind safer than manually copying data files?**  
It understands PostgreSQL timeline divergence and uses WAL to identify and restore changed blocks rather than relying on arbitrary file copying.

10. **What is pg_archivecleanup?**  
A utility that removes older WAL archive files that are no longer required by a configured recovery/replication retention policy.

11. **What is pg_createsubscriber?**  
A PostgreSQL server utility that can convert a physical replica into a logical-replication subscriber as part of supported migration/failover workflows.

12. **What is pg_test_fsync?**  
A utility for testing which WAL synchronization method performs best on a system.

13. **Why should pg_test_fsync not be run casually on a production workload?**  
Storage testing can generate significant I/O and should be planned as an operational experiment.

14. **What is pg_test_timing?**  
A utility for measuring timing overhead and timer behavior relevant to performance diagnostics.

15. **What is pg_resetwal?**  
A recovery utility that can reset WAL/control information when normal startup/recovery is impossible. It is an emergency tool, not routine maintenance.

16. **Why is pg_resetwal dangerous?**  
Incorrect use can cause data loss or corruption. It should be considered only under controlled recovery procedures and normally followed by dump/rebuild validation.

17. **What is dynamic tracing?**  
Instrumentation that allows supported PostgreSQL probes to be observed by tracing systems without permanently adding ad-hoc logging to every code path.

18. **When is dynamic tracing useful?**  
For difficult performance, executor, WAL, lock, I/O or server-internals investigations where normal statistics cannot isolate the behavior.

19. **What is a cumulative statistic?**  
A counter or measurement maintained by PostgreSQL to describe activity over time, such as database, table, index, WAL or I/O activity.

20. **Why must statistics be interpreted with time windows?**  
A counter without a baseline or reset/change point does not tell you whether current activity is normal or abnormal.

21. **What is pg_stat_activity?**  
A view describing current backend sessions, states, queries and related activity.

22. **What is pg_stat_io?**  
A PostgreSQL 18 monitoring view providing detailed I/O statistics by backend/object/context dimensions.

23. **Why correlate PostgreSQL metrics with OS metrics?**  
Database symptoms can originate in CPU, memory, filesystem, storage latency or network behavior outside PostgreSQL itself. PostgreSQL documentation explicitly recommends tools such as ps, top, iostat and vmstat alongside database statistics. citeturn0search11

24. **What is progress reporting?**  
Views exposing the current phase and progress of operations such as VACUUM, CREATE INDEX, COPY, ANALYZE, CLUSTER and base backup.

25. **Why is progress evidence better than a binary 'running' state?**  
It can distinguish active progress from a stalled operation and helps estimate remaining work.

26. **What is disk-full failure?**  
A condition where PostgreSQL cannot allocate required storage, potentially causing transaction failures, WAL/archive problems or inability to complete maintenance.

27. **Why is disk-full recovery different from normal query troubleshooting?**  
The database may need immediate filesystem capacity restoration before ordinary SQL diagnostics can proceed safely.

28. **What is a timeline?**  
A PostgreSQL recovery-history identifier used to distinguish divergent histories after recovery or promotion.

29. **Why are timelines important for pg_rewind and recovery?**  
They establish which WAL history belongs to which branch of the cluster's history.

30. **What is an upgrade evidence package?**  
A reproducible collection of preflight, version, extension, catalog, configuration, statistics, backup and post-upgrade validation results.

31. **Why should pg_upgrade be tested before production?**  
Major upgrades can change optimizer behavior, extensions, defaults and compatibility. PostgreSQL 18 also retains optimizer statistics during pg_upgrade, making plan comparison an important validation step. citeturn0search2

32. **What is the relationship between pg_waldump and normal SQL troubleshooting?**  
SQL-level evidence should be exhausted first; WAL inspection is a deeper diagnostic layer when transaction/recovery behavior must be reconstructed.

33. **What is an observability baseline?**  
A known-good set of workload, latency, CPU, I/O, WAL, locks and replication measurements used for comparison during incidents.

34. **Why should monitoring changes be version-aware?**  
Statistics views and columns evolve between major PostgreSQL releases, so dashboards must be validated after upgrades.

35. **What is a safe incident-evidence sequence?**  
Preserve current state, capture non-invasive SQL/OS evidence, identify impact, then use deeper diagnostic utilities only when justified.

36. **Why should pg_resetwal never be the first recovery action?**  
It changes fundamental WAL/control state and can destroy recovery options. Normal recovery, timeline analysis, backups and supported utilities should be evaluated first.

37. **What is an observability false positive?**  
A metric that appears abnormal but is explained by workload, a reset, an expected maintenance operation or a changed baseline.

38. **How should tracing affect production performance?**  
Measure tracing overhead and enable only the probes needed for the investigation; return to the normal configuration afterward.

39. **What is the difference between evidence collection and remediation?**  
Evidence establishes what happened; remediation changes the system. Keeping them separate reduces the risk of destroying useful diagnostic information.

40. **What is the key operational lesson?**  
Use ordinary SQL/monitoring first, correlate database and OS evidence, escalate to server utilities or tracing when necessary, and avoid irreversible recovery commands without a documented recovery plan.
