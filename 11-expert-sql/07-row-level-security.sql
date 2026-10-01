-- Row-level security restricts which rows a role can see.
ALTER TABLE bank.customer_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY customer_profile_owner_policy
ON bank.customer_profiles
USING (customer_id = current_setting('app.customer_id', true)::bigint);

-- Practice:
-- 1. Create a test role.
-- 2. Set app.customer_id for a session.
-- 3. Verify another customer's rows are hidden.
-- Never test security policies with production credentials.
