# Primary/Standby Checklist

### Primary
- configure WAL/replication settings
- create a replication role
- create a replication slot when appropriate
- capture current WAL position

### Standby
- initialize a separate cluster
- use a base backup/appropriate provisioning method
- configure the primary connection
- start standby recovery
- verify replay progress

### Verification
Compare primary and standby replay/write positions and verify expected read-only behavior on the standby.

### Failure drill
Stop the primary in the disposable lab, document detection and promotion steps, then record the resulting RPO/RTO measurements.