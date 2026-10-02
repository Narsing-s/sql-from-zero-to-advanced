# Failure Matrix

| Failure | Evidence to collect | First safe action | Permanent improvement |
|---|---|---|---|
| Connection exhaustion | pool wait, active/idle sessions, `max_connections` | stop runaway workload and identify holders | pool budgets, timeouts, capacity planning |
| Long transaction | transaction age, xmin, locks | identify owner and business impact | short transaction scope, timeout policy |
| Blocking | blocker PID, wait event, lock relation | identify blocker before terminating anything | consistent transaction ordering |
| Deadlock | server log, involved PIDs/statements | retry aborted transaction safely | deterministic lock ordering |
| WAL pressure | WAL retention, slots, archive status | identify retaining source | slot/archiver monitoring and limits |
| Replication lag | sender/receiver/replay positions | identify lag source before failover | lag alerts and capacity planning |
| Primary failure | health, timeline, replica state | follow documented promotion procedure | tested HA runbook |
| Disk pressure | filesystem/database/WAL usage | stop growth source and preserve evidence | capacity alerts and retention controls |
| Failed recovery | restore logs, checksums/integrity, application checks | isolate recovered environment | scheduled restore drills |
