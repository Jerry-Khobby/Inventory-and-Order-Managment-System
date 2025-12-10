-- Create database
CREATE DATABASE IF NOT EXISTS inventory_management;

-- Select the database
USE inventory_management;


-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(254) CHARACTER SET utf8mb4 NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    shipping_address VARCHAR(255)
);

-- Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

-- Inventory Table
CREATE TABLE Inventory (
    product_id INT PRIMARY KEY,
    quantity INT NOT NULL CHECK (quantity >= 0),
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT (CURRENT_DATE), 
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    order_status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Order_Items Table (Bridge Table for Many-to-Many)
CREATE TABLE Order_Items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    purchase_price DECIMAL(10, 2) NOT NULL CHECK (purchase_price >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);