# Logical Replication Upgrade Checklist

For PostgreSQL 18 logical-replication upgrades, explicitly verify:

- old clusters meet the supported-version prerequisites;
- subscriptions are disabled at the appropriate upgrade point;
- publisher `wal_level` is `logical`;
- `max_replication_slots` is sufficient;
- required output plugins are installed and allowed;
- replication slots are usable;
- subscriber subscription-table states are valid;
- required replication origins exist;
- `max_active_replication_origins` is sufficient;
- backups exist before the multi-node upgrade;
- post-upgrade replication is verified.

Record every prerequisite and its observed value in the upgrade evidence.