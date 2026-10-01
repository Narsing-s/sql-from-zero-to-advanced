CREATE TEMP TABLE returning_demo(id integer PRIMARY KEY, amount numeric);
INSERT INTO returning_demo VALUES (1,100);
UPDATE returning_demo SET amount=125 WHERE id=1 RETURNING OLD.amount AS old_amount, NEW.amount AS new_amount;
DELETE FROM returning_demo WHERE id=1 RETURNING OLD.amount AS old_amount, NEW.amount AS new_amount;
