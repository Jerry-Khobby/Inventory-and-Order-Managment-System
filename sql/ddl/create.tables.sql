
----dropping the first one I had 
DROP DATABASE IF EXISTS inventory_management
-- Create Database
CREATE DATABASE IF NOT EXISTS inventory_management;
USE inventory_management;

-- Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT primary key,
    full_name VARCHAR(100),
    email VARCHAR(254) CHARACTER SET utf8mb4,
    phone VARCHAR(20),
    shipping_address VARCHAR(255)
);

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT primary key,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);


-- Inventory Table
CREATE TABLE IF NOT EXISTS Inventory (
    product_id INT,
    quantity INT
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT primary key,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(50)
);


-- Order_Items Table (Bridge: Many-to-Many)
CREATE TABLE IF NOT EXISTS Order_Items (
    order_id INT,
    product_id INT,
    quantity INT,
    purchase_price DECIMAL(10,2)
);
