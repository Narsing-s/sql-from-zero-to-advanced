DROP TABLE IF EXISTS lab_sales;
CREATE TABLE lab_sales (
  sale_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id bigint NOT NULL,
  amount numeric(12,2) NOT NULL CHECK (amount >= 0),
  sold_at timestamptz NOT NULL DEFAULT now()
);
INSERT INTO lab_sales(customer_id,amount)
SELECT g,(g*10)::numeric FROM generate_series(1,20) g;
DROP MATERIALIZED VIEW IF EXISTS lab_sales_summary;
CREATE MATERIALIZED VIEW lab_sales_summary AS
SELECT customer_id,count(*) AS sale_count,sum(amount) AS total_amount
FROM lab_sales GROUP BY customer_id;
CREATE UNIQUE INDEX lab_sales_summary_customer_uq ON lab_sales_summary(customer_id);
INSERT INTO lab_sales(customer_id,amount) VALUES (1,125.00);
REFRESH MATERIALIZED VIEW CONCURRENTLY lab_sales_summary;
SELECT * FROM lab_sales_summary ORDER BY customer_id;