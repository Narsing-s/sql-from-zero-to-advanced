# Row-Level Security Lab

Use a disposable database and a non-owner application role.

Exercise:
1. Create a tenant-scoped table.
2. Enable RLS.
3. Create a policy based on a session tenant setting.
4. Grant the application role only the required table privileges.
5. Test reads and writes for two tenants.
6. Test an owner role separately.
7. Compare normal RLS with FORCE ROW LEVEL SECURITY.

Success criteria: a tenant cannot read or write another tenant's rows, and policy behavior is verified with explicit tests.