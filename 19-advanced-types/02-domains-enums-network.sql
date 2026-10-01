CREATE DOMAIN non_blank_text AS text CHECK (length(trim(VALUE)) > 0);
CREATE TYPE account_state AS ENUM ('active','blocked','closed');
SELECT '127.0.0.1'::inet << '127.0.0.0/24'::inet AS address_in_network;
