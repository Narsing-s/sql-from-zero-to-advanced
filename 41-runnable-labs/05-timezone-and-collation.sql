SELECT now() AS current_instant,
       now() AT TIME ZONE 'Asia/Kolkata' AS india_local_time,
       now() AT TIME ZONE 'UTC' AS utc_local_time;
SELECT timestamptz '2026-03-29 00:30:00+00' AT TIME ZONE 'Europe/Berlin' AS berlin_time;
SELECT collname,collprovider,collisdeterministic
FROM pg_collation ORDER BY collname LIMIT 25;
SELECT value FROM (VALUES ('a'),('A'),('ä'),('b')) v(value) ORDER BY value;