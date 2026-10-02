# PostgreSQL Server Tools & Deep Observability — 30 Production Scenarios

Use: **Impact → Scope → Evidence → Safe mitigation → Root cause → Permanent fix → Validation → Prevention.**

1. **PostgreSQL will not start after a crash.**  
Capture logs and control-state evidence first. Use pg_controldata and normal recovery diagnostics before considering any destructive recovery action.

2. **A DBA suggests pg_resetwal immediately.**  
Do not use it as a first response. Preserve the data directory, inspect recovery state and available backups/WAL, and follow a documented emergency recovery procedure.

3. **A server reports suspected page corruption.**  
Check data checksums where enabled, capture affected relations/pages, inspect logs and storage health, and use backups/recovery rather than attempting ad-hoc file edits.

4. **The team needs to understand an unexpected WAL event.**  
Use pg_waldump on a safe copy or appropriate WAL evidence to correlate record types with the incident timeline.

5. **WAL summaries appear inconsistent with expectations.**  
Use pg_walsummary and compare the affected WAL range with backup/recovery metadata before concluding that the summary indicates corruption.

6. **A failed primary has a promoted standby and the old primary must rejoin.**  
Confirm the timeline relationship and use pg_rewind where prerequisites are satisfied rather than manually copying data files.

7. **pg_rewind cannot run.**  
Check prerequisites, timeline divergence, required WAL availability and configuration. If prerequisites are absent, use a supported rebuild/recovery path.

8. **WAL archives are filling the archive filesystem.**  
Determine which backups, replicas or recovery processes still need the files before running archive cleanup. Never delete WAL solely because the directory is large.

9. **A storage benchmark is needed for WAL sync performance.**  
Schedule pg_test_fsync in a controlled environment or maintenance window and compare results with actual workload behavior.

10. **Database timing appears unstable.**  
Use pg_test_timing and OS-level evidence to distinguish timer overhead from genuine query latency.

11. **CPU is high but pg_stat_activity does not identify the cause.**  
Correlate PostgreSQL statistics with OS process/thread CPU, query plans and workload timing. Use deeper tracing only after narrowing the hypothesis.

12. **I/O latency suddenly increases.**  
Inspect pg_stat_io and PostgreSQL wait/activity evidence, then correlate with iostat and filesystem/storage telemetry.

13. **VACUUM looks stuck.**  
Use progress reporting to determine its phase and correlate with locks, I/O, transaction age and table size before terminating it.

14. **CREATE INDEX is taking hours.**  
Inspect pg_stat_progress_create_index, locks, I/O and concurrent workload. Determine whether it is progressing or blocked before changing the operation.

15. **A base backup appears frozen.**  
Use base-backup progress and OS throughput evidence to distinguish slow storage from an actual stall.

16. **Disk usage reaches 95%.**  
Identify database, WAL, archive, temporary-file and filesystem consumers. Restore safe capacity before maintenance failures cascade.

17. **Disk reaches 100% during a production incident.**  
Prioritize safe capacity recovery, preserve WAL/archive requirements, and avoid deleting unknown database files.

18. **An upgrade completed but queries changed plans.**  
Compare pre/post EXPLAIN plans, statistics and PostgreSQL versions. PostgreSQL 18's pg_upgrade retention of optimizer statistics makes this comparison especially useful. citeturn0search2

19. **An upgrade dashboard stopped working.**  
Check whether monitoring view columns or semantics changed between major versions and update the dashboard using the target-version documentation.

20. **A monitoring counter suddenly drops.**  
Check whether statistics were reset or the instance restarted before declaring a workload improvement.

21. **A replication incident requires low-level timeline evidence.**  
Capture control-state and WAL/timeline information before changing the cluster so the failure history remains reconstructable.

22. **A custom extension causes CPU spikes.**  
Correlate extension activity with backend processes and workload timing; use dynamic tracing only where supported and necessary.

23. **A lock incident cannot be explained by pg_locks alone.**  
Combine session activity, wait events, query plans, transaction age and OS evidence; deeper tracing may help identify server-internal wait paths.

24. **A DBA wants to enable every trace probe in production.**  
Use the smallest useful probe set and measure overhead. Broad tracing can add noise and overhead.

25. **An incident commander asks what evidence must be captured before restart.**  
Capture current sessions, blockers, replication state, WAL/LSN positions, progress views, relevant configuration, filesystem state and timestamps before changing the server.

26. **A standby was promoted and the old primary has divergent writes.**  
Treat the old primary as a divergent timeline. Preserve evidence, validate the new primary, and use pg_rewind or rebuild according to prerequisites.

27. **Backup exists but the team cannot prove it is usable.**  
Verify backup metadata/manifest, required WAL range and restoration procedure. A file existing on disk is not proof of recoverability.

28. **An SRE sees high I/O but low query latency.**  
Do not infer an incident from one metric. Compare workload, cache behavior, maintenance activity and historical baselines.

29. **A database is healthy but the host storage is failing.**  
Treat infrastructure telemetry as part of the database incident. Reduce risky write amplification if possible and coordinate storage remediation without corrupting the database.

30. **Interviewer asks how to troubleshoot a PostgreSQL production incident.**  
Start with impact and timestamps; capture non-invasive SQL/OS evidence; inspect sessions, locks, I/O, WAL, replication and progress; form hypotheses; mitigate safely; validate; then perform RCA and prevention. PostgreSQL's monitoring documentation explicitly recommends combining database statistics with OS tools and EXPLAIN. citeturn0search11
