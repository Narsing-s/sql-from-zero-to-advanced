-- Slowly Changing Dimension Type 2
-- Keep historical versions instead of overwriting the previous value.

DROP TABLE IF EXISTS customer_dimension;

CREATE TABLE customer_dimension (
    customer_sk BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    customer_name TEXT NOT NULL,
    city TEXT,
    valid_from TIMESTAMPTZ NOT NULL,
    valid_to TIMESTAMPTZ,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    CHECK (valid_to IS NULL OR valid_to > valid_from)
);

INSERT INTO customer_dimension
    (customer_id, customer_name, city, valid_from)
VALUES
    (1001, 'Asha', 'Visakhapatnam', now());

-- Close the current version before inserting a new version.
UPDATE customer_dimension
SET valid_to = now(),
    is_current = FALSE
WHERE customer_id = 1001
  AND is_current = TRUE;

INSERT INTO customer_dimension
    (customer_id, customer_name, city, valid_from)
VALUES
    (1001, 'Asha', 'Hyderabad', now());

SELECT *
FROM customer_dimension
WHERE customer_id = 1001
ORDER BY valid_from;
