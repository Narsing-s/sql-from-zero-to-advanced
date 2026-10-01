DROP TABLE IF EXISTS lab_orders;
CREATE TABLE lab_orders (
  order_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  status text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE OR REPLACE FUNCTION lab_notify_order() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  PERFORM pg_notify('order_events', json_build_object('order_id',NEW.order_id,'status',NEW.status)::text);
  RETURN NEW;
END;
$$;
CREATE TRIGGER lab_orders_notify
AFTER INSERT OR UPDATE OF status ON lab_orders
FOR EACH ROW EXECUTE FUNCTION lab_notify_order();

-- Session A: LISTEN order_events;
INSERT INTO lab_orders(status) VALUES ('created');
UPDATE lab_orders SET status='paid' WHERE order_id=1;

-- LISTEN/NOTIFY is signaling, not a durable queue.