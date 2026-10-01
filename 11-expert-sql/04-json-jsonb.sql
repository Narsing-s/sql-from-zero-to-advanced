-- JSONB is useful when some attributes are naturally semi-structured.
CREATE TABLE IF NOT EXISTS bank.customer_profiles (
  customer_id BIGINT PRIMARY KEY REFERENCES bank.customers(customer_id),
  preferences JSONB NOT NULL DEFAULT '{}'::jsonb
);

INSERT INTO bank.customer_profiles(customer_id, preferences)
VALUES (1, '{"language":"en","alerts":{"email":true,"sms":false}}')
ON CONFLICT (customer_id) DO UPDATE
SET preferences = EXCLUDED.preferences;

SELECT customer_id
FROM bank.customer_profiles
WHERE preferences @> '{"language":"en"}';

SELECT preferences->'alerts'->>'email' AS email_alert
FROM bank.customer_profiles
WHERE customer_id = 1;
