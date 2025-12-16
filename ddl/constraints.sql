-- Primary Keys
ALTER TABLE Order_Items
    ADD CONSTRAINT pk_order_items PRIMARY KEY (order_id, product_id);

-- UNIQUE Constraints
ALTER TABLE Customers
    ADD CONSTRAINT uq_customers_email UNIQUE (email);

-- NOT NULL Constraints
ALTER TABLE Customers
    MODIFY full_name VARCHAR(100) NOT NULL,
    MODIFY email VARCHAR(254) NOT NULL,
    MODIFY phone VARCHAR(20) NOT NULL,
    MODIFY shipping_address VARCHAR(255) NOT NULL;

ALTER TABLE Products
    MODIFY product_name VARCHAR(100) NOT NULL,
    MODIFY price DECIMAL(10,2) NOT NULL;

ALTER TABLE Inventory
    MODIFY quantity INT NOT NULL;

ALTER TABLE Orders
    MODIFY customer_id INT NOT NULL,
    MODIFY order_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    MODIFY total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    MODIFY order_status VARCHAR(50) NOT NULL DEFAULT 'Pending';

ALTER TABLE Order_Items
    MODIFY quantity INT NOT NULL,
    MODIFY purchase_price DECIMAL(10,2) NOT NULL;

-- CHECK Constraints
ALTER TABLE Products
    ADD CONSTRAINT chk_product_price CHECK (price >= 0);

ALTER TABLE Inventory
    ADD CONSTRAINT chk_inventory_quantity CHECK (quantity >= 0);

ALTER TABLE Orders
    ADD CONSTRAINT chk_order_total CHECK (total_amount >= 0);

ALTER TABLE Order_Items
    ADD CONSTRAINT chk_order_items_quantity CHECK (quantity > 0),
    ADD CONSTRAINT chk_order_items_price CHECK (purchase_price >= 0);

-- Foreign Keys
ALTER TABLE Inventory
    ADD CONSTRAINT fk_inventory_product
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Orders
    ADD CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Order_Items
    ADD CONSTRAINT fk_order_items_order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Order_Items
    ADD CONSTRAINT fk_order_items_product
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
