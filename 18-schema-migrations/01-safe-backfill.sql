-- Adapt the table/column names to your schema.
BEGIN;
WITH batch AS (SELECT id FROM customer_profile WHERE normalized_email IS NULL ORDER BY id LIMIT 500)
UPDATE customer_profile c SET normalized_email = lower(trim(c.email)) FROM batch b WHERE c.id=b.id;
COMMIT;
SELECT count(*) FILTER (WHERE normalized_email IS NULL) AS remaining FROM customer_profile;
