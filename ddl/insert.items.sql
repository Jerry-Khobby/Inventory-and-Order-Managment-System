
------insert into customer
INSERT INTO Customers (full_name, email, phone, shipping_address) VALUES
('John Smith', 'john.smith@example.com', '555-1234', '123 Elm Street, New York, NY'),
('Alice Johnson', 'alice.johnson@example.com', '555-5678', '456 Oak Avenue, Los Angeles, CA'),
('Michael Brown', 'michael.brown@example.com', '555-9012', '789 Pine Road, Chicago, IL'),
('Emily Davis', 'emily.davis@example.com', '555-3456', '321 Maple Street, Houston, TX'),
('David Wilson', 'david.wilson@example.com', '555-7890', '654 Cedar Lane, Phoenix, AZ');



---insert into Products 
INSERT INTO Products (product_name, category, price) VALUES
('Apple iPhone 15', 'Electronics', 999.99),
('Samsung Galaxy S23', 'Electronics', 899.99),
('Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
('Levi''s 501 Jeans', 'Apparel', 79.99),
('Nike Air Max 270', 'Apparel', 149.99),
('The Great Gatsby', 'Books', 15.99),
('Harry Potter Box Set', 'Books', 89.99),
('Instant Pot Duo 7-in-1', 'Home Appliances', 129.99),
('Dyson V11 Vacuum', 'Home Appliances', 599.99),
('Kindle Paperwhite', 'Electronics', 139.99);


--insert into Inventory 
INSERT INTO Inventory (product_id, quantity) VALUES
(1, 50),
(2, 40),
(3, 75),
(4, 100),
(5, 80),
(6, 200),
(7, 150),
(8, 60),
(9, 30),
(10, 120);


-- insert into Orders
INSERT INTO Orders (customer_id, order_date, total_amount, order_status) VALUES
(1, '2025-12-01', 1099.98, 'Shipped'),
(2, '2025-12-03', 349.99, 'Delivered'),
(3, '2025-12-05', 229.98, 'Pending'),
(1, '2025-12-07', 79.99, 'Delivered'),
(4, '2025-12-08', 249.98, 'Shipped');

-- insert into Order_items 
INSERT INTO Order_Items (order_id, product_id, quantity, purchase_price) VALUES
(1, 1, 1, 999.99),
(1, 5, 1, 149.99),
(2, 3, 1, 349.99),
(3, 4, 2, 79.99),
(4, 4, 1, 79.99),
(5, 5, 2, 124.99);
