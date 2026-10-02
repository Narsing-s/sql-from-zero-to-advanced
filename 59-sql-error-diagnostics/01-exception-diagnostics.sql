CREATE TEMP TABLE diagnostic_demo (
  id integer PRIMARY KEY,
  value text NOT NULL
);

INSERT INTO diagnostic_demo VALUES (1, 'first');

DO $$
DECLARE
  v_sqlstate text;
  v_message text;
  v_detail text;
  v_hint text;
  v_constraint text;
BEGIN
  BEGIN
    INSERT INTO diagnostic_demo VALUES (1, 'duplicate');
  EXCEPTION WHEN unique_violation THEN
    GET STACKED DIAGNOSTICS
      v_sqlstate = RETURNED_SQLSTATE,
      v_message = MESSAGE_TEXT,
      v_detail = PG_EXCEPTION_DETAIL,
      v_hint = PG_EXCEPTION_HINT,
      v_constraint = CONSTRAINT_NAME;

    RAISE NOTICE 'sqlstate=% message=% detail=% hint=% constraint=%',
      v_sqlstate, v_message, v_detail, v_hint, v_constraint;
  END;
END
$$;

-- Prefer SQLSTATE and structured diagnostics in application error mapping.
