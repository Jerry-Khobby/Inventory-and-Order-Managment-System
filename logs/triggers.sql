---- table to log trigger events 

CREATE TABLE IF NOT EXISTS TriggerLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    trigger_name VARCHAR(100),
    table_name VARCHAR(100),
    action VARCHAR(10),
    log_message VARCHAR(255),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM;  


DELIMITER $$

-- Log successful inserts into Order_Items
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

-- Log successful updates to Inventory
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

DELIMITER ;




/* SELECT * 
FROM inventory_management.TriggerLogs
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/trigger_logs.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
 */

