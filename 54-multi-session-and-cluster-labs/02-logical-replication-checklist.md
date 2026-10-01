# Logical Replication Harness Checklist

## Publisher
- set wal_level=logical
- create replication-capable role
- create publication
- insert/update/delete fixture rows

## Subscriber
- create matching target tables
- create subscription
- wait for initial synchronization
- verify replicated rows

## Monitoring
Check pg_stat_subscription, pg_stat_subscription_stats, pg_replication_slots and publisher WAL retention.

## PostgreSQL 18 checks
PostgreSQL 18 supports logical replication of generated columns and parallel subscription streaming. Conflicts are exposed through subscription statistics. Keep these checks in the dedicated cluster lab rather than normal single-node CI.