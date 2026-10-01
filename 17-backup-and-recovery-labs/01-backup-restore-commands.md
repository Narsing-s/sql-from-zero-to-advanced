# Backup and restore commands

Logical backup:
~~~bash
pg_dump -Fc -d sql_learning -f sql_learning.dump
createdb sql_restore_test
pg_restore -d sql_restore_test sql_learning.dump
~~~

Cluster globals:
~~~bash
pg_dumpall --globals-only > globals.sql
~~~

Physical base backup:
~~~bash
pg_basebackup -D ./basebackup -Fp -Xs -P
~~~

Run these first in a disposable/local environment.
