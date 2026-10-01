-- ============================================================
-- Banking project — reporting queries
-- ============================================================
--
-- Definition:
-- A reporting query transforms operational data into information
-- useful for analysis, monitoring, and business decisions.
--
-- Purpose:
-- Combine joins, window functions, aggregation, and NULL handling.
--
-- Mental model:
-- Operational rows -> join/aggregate/window -> business report
--
-- Expected result:
-- Report 1 ranks accounts by balance. Report 2 calculates each
-- customer's total balance, including customers with no account.
--
-- Line-by-line:
-- RANK() creates a relative position without collapsing account rows.
-- LEFT JOIN keeps customers even when no account exists.
-- SUM calculates the customer's total.
-- COALESCE changes a NULL total into zero.
--
-- Practice:
-- Add a report showing total balance by branch.
--
-- Performance:
-- Reporting queries can become expensive on large operational tables.
-- Measure plans, indexes, and workload before optimizing.
--
-- Security:
-- Reports should expose only the fields the consuming role needs.
--
-- Production use:
-- Mature reporting workloads may use replicas, materialized views,
-- warehouse tables, or dedicated analytics systems.
--
-- Interview:
-- Why is COALESCE useful in the second report?
-- ============================================================

SELECT c.first_name,c.last_name,a.account_number,a.balance,
       RANK() OVER(ORDER BY a.balance DESC) AS balance_rank
FROM bank.accounts a
JOIN bank.customers c ON c.customer_id=a.customer_id;

SELECT c.customer_id,c.first_name,c.last_name,
       COALESCE(SUM(a.balance),0) AS total_balance
FROM bank.customers c
LEFT JOIN bank.accounts a USING(customer_id)
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_balance DESC;
