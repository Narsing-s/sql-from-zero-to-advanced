# Curriculum Acceptance Criteria

The curriculum is considered complete when:
- every stage has execution instructions;
- runnable SQL has fixtures or documented prerequisites;
- destructive, privileged, recovery and replication labs are not silently included in normal CI;
- PostgreSQL-version-specific labs identify their minimum version;
- examples avoid production credentials;
- application examples use parameter binding;
- concurrency labs document session ordering;
- replication labs document setup and teardown;
- backup labs include restore verification;
- performance labs capture workload and environment metadata;
- UI exposes every curriculum stage;
- UI build and TypeScript checks run in CI;
- README, roadmap and curriculum matrix agree on stage count.