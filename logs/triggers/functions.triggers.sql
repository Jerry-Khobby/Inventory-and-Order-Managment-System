-- Drop existing triggers if they exist
DROP TRIGGER IF EXISTS log_inventory_change;
DROP TRIGGER IF EXISTS log_order_status_change;
DROP TRIGGER IF EXISTS log_new_order;

-- Trigger 1: Log inventory changes
DELIMITER $$

CREATE TRIGGER log_inventory_change
AFTER UPDATE ON Inventory
FOR EACH ROW
BEGIN
    IF OLD.quantity != NEW.quantity THEN
        INSERT INTO Inventory_Logs (
            product_id,
            change_type,
            quantity_before,
            quantity_after,
            quantity_changed,
            reason
        )
        VALUES (
            NEW.product_id,
            'ADJUSTMENT',
            OLD.quantity,
            NEW.quantity,
            NEW.quantity - OLD.quantity,
            'Automatic inventory update'
        );
    END IF;
END $$

DELIMITER ;

-- Trigger 2: Log order status changes
DELIMITER $$

CREATE TRIGGER log_order_status_change
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF OLD.order_status != NEW.order_status OR OLD.total_amount != NEW.total_amount THEN
        INSERT INTO Order_Logs (
            order_id,
            customer_id,
            action_type,
            old_status,
            new_status,
            old_total_amount,
            new_total_amount,
            notes
        )
        VALUES (
            NEW.order_id,
            NEW.customer_id,
            'STATUS_CHANGE',
            OLD.order_status,
            NEW.order_status,
            OLD.total_amount,
            NEW.total_amount,
            CONCAT('Status changed from ', OLD.order_status, ' to ', NEW.order_status)
        );
    END IF;
END $$

DELIMITER ;

-- Trigger 3: Log new orders
DELIMITER $$

CREATE TRIGGER log_new_order
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_Logs (
        order_id,
        customer_id,
        action_type,
        new_status,
        new_total_amount,
        notes
    )
    VALUES (
        NEW.order_id,
        NEW.customer_id,
        'CREATE',
        NEW.order_status,
        NEW.total_amount,
        'New order created'
    );
END $$

DELIMITER ;