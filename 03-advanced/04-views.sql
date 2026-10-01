-- ============================================================
-- 04 — Views: reusable virtual result sets
-- ============================================================
--
-- Definition:
-- A view is a named query that can be queried like a table. A normal
-- view stores the definition, not a separate copy of the result data.
--
-- Purpose:
-- Hide repeated join logic and expose a simpler interface to users
-- or applications.
--
-- Mental model:
-- Base tables -> saved SELECT definition -> view -> SELECT from view
--
-- Syntax:
-- CREATE OR REPLACE VIEW name AS SELECT ...;
--
-- Expected result:
-- customer_account_summary shows customer and account information,
-- including customers with no account because the query uses LEFT JOIN.
--
-- Common mistake:
-- Treating a normal view as a performance cache. Use a materialized view
-- when persisted query results are appropriate.
--
-- Security:
-- Expose only required columns through views where that supports the
-- database's access-control design.
--
-- Production use:
-- Views provide stable reporting interfaces and centralize reusable SQL.
--
-- Interview:
-- What is the difference between a view and a materialized view?
-- ============================================================

SET search_path TO beginner;

CREATE OR REPLACE VIEW customer_account_summary AS
SELECT c.customer_id,c.first_name,c.last_name,
       a.account_number,a.account_type,a.balance
FROM customers c
LEFT JOIN accounts a USING(customer_id);

SELECT * FROM customer_account_summary;
