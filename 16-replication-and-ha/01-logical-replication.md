# Logical replication lab

Use two disposable PostgreSQL instances.

Publisher:
~~~sql
CREATE PUBLICATION app_pub FOR TABLE public.customers;
SELECT * FROM pg_publication;
~~~

Subscriber:
~~~sql
CREATE SUBSCRIPTION app_sub CONNECTION 'host=SOURCE dbname=app user=repl password=REPLACE_ME' PUBLICATION app_pub;
SELECT * FROM pg_subscription;
~~~

Test INSERT/UPDATE/DELETE, subscriber downtime and conflict handling. Never commit real credentials.
