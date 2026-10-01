# Lock-aware migration checklist

Determine required lock level, possible blocking, scan duration, transaction timeout policy, whether CREATE INDEX CONCURRENTLY is appropriate, validation steps and rollback/forward-fix strategy. Test migrations at production-scale data volume, not only on empty development databases.
