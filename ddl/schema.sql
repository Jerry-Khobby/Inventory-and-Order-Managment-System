-- Drop and recreate database
DROP DATABASE IF EXISTS inventory_management;
CREATE DATABASE IF NOT EXISTS inventory_management;
USE inventory_management;


-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(254) CHARACTER SET utf8mb4 NOT NULL,
    phone VARCHAR(20) NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    
    CONSTRAINT uq_customers_email UNIQUE (email)
);


-- Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT chk_product_price CHECK (price >= 0)
);


-- Inventory Table
CREATE TABLE Inventory (
    product_id INT PRIMARY KEY,
    quantity INT NOT NULL,
    
    CONSTRAINT chk_inventory_quantity CHECK (quantity >= 0),
    
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    order_status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    
    CONSTRAINT chk_order_total CHECK (total_amount >= 0),
    
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Order_Items Table
CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    purchase_price DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT pk_order_items 
        PRIMARY KEY (order_id, product_id),
    
    CONSTRAINT chk_order_items_quantity 
        CHECK (quantity > 0),
        
    CONSTRAINT chk_order_items_price 
        CHECK (purchase_price >= 0),
    
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Indexes
CREATE INDEX idx_orders_customer
    ON Orders(customer_id);

CREATE INDEX idx_order_items_product
    ON Order_Items(product_id);
