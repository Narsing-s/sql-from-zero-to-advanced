-- 41.11 — Event-trigger audit lab
-- Requires a disposable database and a role allowed to create event triggers.
-- Event triggers operate at database scope; do not install this in production
-- without an explicit governance/security review.

DROP TABLE IF EXISTS ddl_audit_log;
CREATE TABLE ddl_audit_log (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  event_time timestamptz NOT NULL DEFAULT clock_timestamp(),
  username name NOT NULL DEFAULT current_user,
  command_tag text,
  object_type text,
  schema_name text,
  object_identity text
);

CREATE OR REPLACE FUNCTION ddl_audit_capture()
RETURNS event_trigger
LANGUAGE plpgsql
AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    INSERT INTO ddl_audit_log(command_tag, object_type, schema_name, object_identity)
    VALUES (
      cmd.command_tag,
      cmd.object_type,
      cmd.schema_name,
      cmd.object_identity
    );
  END LOOP;
END;
$$;

DROP EVENT TRIGGER IF EXISTS ddl_audit_capture_trigger;
CREATE EVENT TRIGGER ddl_audit_capture_trigger
ON ddl_command_end
EXECUTE FUNCTION ddl_audit_capture();

CREATE TABLE ddl_audit_demo(id bigint PRIMARY KEY);
ALTER TABLE ddl_audit_demo ADD COLUMN note text;

SELECT *
FROM ddl_audit_log
ORDER BY id;

DROP EVENT TRIGGER ddl_audit_capture_trigger;
DROP FUNCTION ddl_audit_capture();
DROP TABLE ddl_audit_demo;
DROP TABLE ddl_audit_log;
