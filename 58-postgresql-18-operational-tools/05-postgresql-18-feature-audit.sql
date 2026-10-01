\set ON_ERROR_STOP on
SELECT current_setting('server_version') AS server_version;
SELECT current_setting('server_version_num') AS server_version_num;

SELECT name, default_version
FROM pg_available_extensions
WHERE name IN ('amcheck')
ORDER BY name;

SELECT name, setting
FROM pg_settings
WHERE name IN (
  'wal_level',
  'max_replication_slots',
  'max_wal_senders',
  'max_active_replication_origins'
)
ORDER BY name;

SELECT current_setting('data_checksums') AS data_checksums;
