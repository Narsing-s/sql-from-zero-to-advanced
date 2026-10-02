-- PostgreSQL replication/recovery evidence.
-- Commands that promote or stop servers belong in the disposable-cluster runbook.

SELECT pg_is_in_recovery();

SELECT now() AS observed_at,
       pg_current_wal_lsn() AS primary_wal_lsn;

SELECT application_name, client_addr, state, sync_state,
       sent_lsn, write_lsn, flush_lsn, replay_lsn,
       write_lag, flush_lag, replay_lag
FROM pg_stat_replication
ORDER BY application_name;

SELECT slot_name, slot_type, active,
       restart_lsn, confirmed_flush_lsn
FROM pg_replication_slots
ORDER BY slot_name;

-- Recovery verification should also confirm application reads/writes,
-- expected timeline/role, backup status and monitoring.
