
-- Make sure the logging table exists
CREATE TABLE IF NOT EXISTS TriggerLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    trigger_name VARCHAR(100),
    table_name VARCHAR(100),
    action VARCHAR(10),
    log_message VARCHAR(255),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


DELIMITER $$


-- 1. Log INSERTS into Order_Items
CREATE TRIGGER trg_order_items_log_success
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    INSERT INTO TriggerLogs(trigger_name, table_name, action, log_message)
    VALUES (
        'trg_order_items_log_success',
        'Order_Items',
        'INSERT',
        CONCAT('Order_Item added: order_id=', NEW.order_id,
               ', product_id=', NEW.product_id,
               ', quantity=', NEW.quantity)
    );

END$$


-- 2. Log UPDATES to Inventory
CREATE TRIGGER trg_inventory_log_update
AFTER UPDATE ON Inventory
FOR EACH ROW
BEGIN
    INSERT INTO TriggerLogs(trigger_name, table_name, action, log_message)
    VALUES (
        'trg_inventory_log_update',
        'Inventory',
        'UPDATE',
        CONCAT('Inventory updated: product_id=', NEW.product_id,
               ', old_quantity=', OLD.quantity,
               ', new_quantity=', NEW.quantity)
    );
END$$

-- =========================
-- 3. Prevent Negative Inventory
-- =========================
CREATE TRIGGER trg_inventory_prevent_negative
BEFORE UPDATE ON Inventory
FOR EACH ROW
BEGIN
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Inventory cannot be negative';
    END IF;
END$$


-- 4. Validate Stock BEFORE inserting into Order_Items
CREATE TRIGGER trg_order_items_check_stock
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    DECLARE v_current_stock INT;

    SELECT quantity
    INTO v_current_stock
    FROM Inventory
    WHERE product_id = NEW.product_id;

    IF v_current_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Inventory record not found for product';
    END IF;

    IF v_current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for product';
    END IF;
END$$

-- 5. Auto-deduct inventory AFTER inserting into Order_Items
CREATE TRIGGER trg_auto_deduct_inventory
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$


-- Auto-update Orders total_amount AFTER inserting into Order_Items
CREATE TRIGGER trg_update_order_total
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET total_amount = (
        SELECT SUM(quantity * purchase_price)
        FROM Order_Items
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END$$


-- Validate Order Status Transitions
CREATE TRIGGER trg_validate_order_status
BEFORE UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF OLD.order_status = 'Delivered'
       AND NEW.order_status <> 'Delivered' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Delivered orders cannot be modified';
    END IF;
END$$

DELIMITER ;


--SELECT * FROM TriggerLogs ORDER BY log_time DESC;

