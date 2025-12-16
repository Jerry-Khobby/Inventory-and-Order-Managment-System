DROP TABLE IF EXISTS Order_Error_Logs;
DROP TABLE IF EXISTS Customer_Activity_Logs;
DROP TABLE IF EXISTS Inventory_Logs;
DROP TABLE IF EXISTS Order_Logs;


-- Order Activity Log
CREATE TABLE Order_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    customer_id INT,
    action_type ENUM('CREATE', 'UPDATE', 'DELETE', 'STATUS_CHANGE') NOT NULL,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    old_total_amount DECIMAL(10,2),
    new_total_amount DECIMAL(10,2),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action_by VARCHAR(100) DEFAULT USER(),
    notes TEXT,
    INDEX idx_order_id (order_id),
    INDEX idx_timestamp (action_timestamp)
);

-- Inventory Change Log
CREATE TABLE Inventory_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    change_type ENUM('SALE', 'RESTOCK', 'ADJUSTMENT', 'RETURN') NOT NULL,
    quantity_before INT NOT NULL,
    quantity_after INT NOT NULL,
    quantity_changed INT NOT NULL,
    order_id INT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by VARCHAR(100) DEFAULT USER(),
    reason TEXT,
    INDEX idx_product_id (product_id),
    INDEX idx_order_id (order_id),
    INDEX idx_timestamp (changed_at),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Order Error Log
CREATE TABLE Order_Error_Logs (
    error_log_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_items JSON,
    error_message TEXT NOT NULL,
    error_code VARCHAR(10),
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_customer_id (customer_id),
    INDEX idx_timestamp (attempted_at)
);

-- Customer Activity Log
CREATE TABLE Customer_Activity_Logs (
    activity_log_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    activity_type ENUM('ORDER_PLACED', 'ORDER_CANCELLED', 'PROFILE_UPDATED') NOT NULL,
    order_id INT,
    activity_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    INDEX idx_customer_id (customer_id),
    INDEX idx_timestamp (activity_timestamp),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);