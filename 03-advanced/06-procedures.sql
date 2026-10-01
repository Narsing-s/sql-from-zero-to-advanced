CREATE OR REPLACE PROCEDURE public.add_interest(p_rate NUMERIC) LANGUAGE SQL AS $$ UPDATE beginner.accounts SET balance=ROUND(balance*(1+p_rate/100),2); $$;
-- CALL public.add_interest(2.5);