# PostgreSQL 18.6 Maintenance Lab

PostgreSQL 18.6 was released on August 13, 2026. The 18.6 release includes fixes and security-related configuration changes.

## Logical decoding plugin allow-list

18.6 restricts logical decoding output plugins to the libraries listed by the server parameter output_plugin_libraries. The default allow-list includes the PostgreSQL-shipped pgoutput and test_decoding plugins.

Before a major-version upgrade, verify that every logical replication slot's output plugin is allowed by the target cluster. pg_upgrade --check can detect an incompatible output_plugin_libraries setting.

## Operational checklist

1. Record the current PostgreSQL version.
2. Inventory logical replication slots and their plugins.
3. Review output_plugin_libraries.
4. Verify extension/output-plugin compatibility.
5. Run pg_upgrade --check or the chosen upgrade rehearsal.
6. Validate logical replication after upgrade.
7. Record the result in the upgrade runbook.

## Related labs

- 16-replication-and-ha/
- 33-migration-and-upgrade-labs/
- 40-final-production-lab/

Do not change production configuration solely from this note; validate the installed PostgreSQL minor version and its release notes first.
