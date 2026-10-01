# SQL Safety Checklist

Before executing a write or DDL lab:
- [ ] disposable database
- [ ] PostgreSQL version documented
- [ ] target schema explicit
- [ ] destructive statements reviewed
- [ ] transaction/rollback plan where appropriate
- [ ] lock impact considered
- [ ] disk/WAL impact considered
- [ ] replication impact considered
- [ ] required roles documented
- [ ] expected results documented
- [ ] cleanup documented

Concurrency and recovery labs should use isolated instances.