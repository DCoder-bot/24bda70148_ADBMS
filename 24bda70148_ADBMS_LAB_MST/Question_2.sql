CREATE OR REPLACE FUNCTION log_customer_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO customer_audit
    (customer_id, customer_name, action, action_time)
    VALUES
    (NEW.customer_id, NEW.customer_name, 'ADDED', CURRENT_TIMESTAMP);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_customer_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO customer_audit
    (customer_id, customer_name, action, action_time)
    VALUES
    (OLD.customer_id, OLD.customer_name, 'REMOVED', CURRENT_TIMESTAMP);

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_customer_insert
AFTER INSERT ON bank_customer
FOR EACH ROW
EXECUTE FUNCTION log_customer_insert();

CREATE TRIGGER after_customer_delete
AFTER DELETE ON bank_customer
FOR EACH ROW
EXECUTE FUNCTION log_customer_delete();