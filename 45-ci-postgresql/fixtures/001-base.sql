DROP SCHEMA IF EXISTS ci_lab CASCADE;
CREATE SCHEMA ci_lab;

CREATE TABLE ci_lab.customers (
  customer_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_name text NOT NULL,
  active boolean NOT NULL DEFAULT true
);

CREATE TABLE ci_lab.orders (
  order_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id bigint NOT NULL REFERENCES ci_lab.customers(customer_id),
  amount numeric(12,2) NOT NULL CHECK (amount >= 0),
  created_at timestamptz NOT NULL DEFAULT now()
);

INSERT INTO ci_lab.customers(customer_name) VALUES
('Alice'),('Bob'),('Carol');

INSERT INTO ci_lab.orders(customer_id,amount) VALUES
(1,100.00),(1,25.50),(2,200.00);