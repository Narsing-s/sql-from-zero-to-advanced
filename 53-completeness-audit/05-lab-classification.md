# Lab Classification

Executable exercises must be classified before automated execution.

| Class | Default CI |
|---|---|
| safe-single-session | Yes, when deterministic |
| multi-session | No |
| privileged | No |
| destructive | No |
| recovery | No |
| replication | No |
| client-runtime | Separate workflow |

For every new lab document PostgreSQL minimum version, required configuration, cleanup, expected result, session requirements and whether it is safe for the default CI environment.

This mirrors PostgreSQL's own separation of core regression tests from concurrent-session isolation, crash recovery/physical replication, logical replication and client tests.