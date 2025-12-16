---- table to log trigger events 

CREATE TABLE IF NOT EXISTS TriggerLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    trigger_name VARCHAR(100),
    table_name VARCHAR(100),
    action VARCHAR(10),
    log_message VARCHAR(255),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



DELIMITER $$

CREATE TRIGGER trg_order_items_check_stock
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;

    SELECT quantity
    INTO v_stock
    FROM Inventory
    WHERE product_id = NEW.product_id;

    IF v_stock IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Inventory record not found for product';
    END IF;

    IF v_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient inventory for product';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_inventory_prevent_negative
BEFORE UPDATE ON Inventory
FOR EACH ROW
BEGIN
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Inventory quantity cannot be negative';
    END IF;
END$$

DELIMITER ;


--mysql -u your_username -p -e "SELECT * FROM inventory_management.TriggerLogs;" > trigger_logs.csv

