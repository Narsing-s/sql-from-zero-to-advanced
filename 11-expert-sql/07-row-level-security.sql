-- ============================================================
-- 07 — Row-Level Security (RLS)
-- ============================================================
--
-- Definition:
-- Row-Level Security adds policies that control which table rows a
-- database role can access or modify.
--
-- Purpose:
-- Demonstrate tenant/user-aware filtering enforced by PostgreSQL.
--
-- Mental model:
-- SQL request -> table policy -> allowed rows -> result
--
-- Expected result:
-- With a correctly configured role/session context, only rows matching
-- the current app.customer_id should be visible through the policy.
--
-- Important:
-- RLS is part of a security design, not a replacement for application
-- authorization. Test owner, role, BYPASSRLS, and policy behavior carefully.
--
-- Security:
-- Never test security policies with production credentials. Use dedicated
-- test roles and verify both allowed and denied cases.
--
-- Production use:
-- Multi-tenant applications and user-scoped data access can use RLS
-- as an additional database enforcement layer.
--
-- Practice:
-- Create a test role, set app.customer_id, and verify another customer's
-- rows are not returned.
--
-- Interview:
-- What problem does RLS solve, and why is it not a complete authorization
-- system by itself?
-- ============================================================

ALTER TABLE bank.customer_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY customer_profile_owner_policy
ON bank.customer_profiles
USING (customer_id = current_setting('app.customer_id', true)::bigint);

-- Practice:
-- 1. Create a test role.
-- 2. Set app.customer_id for a session.
-- 3. Verify another customer's rows are hidden.
-- Never test security policies with production credentials.
