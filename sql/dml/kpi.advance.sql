---- Total Revenue 
Select sum(total_amount) as total_revenue from orders where 
order_status in ('Shipped','Delivered')


---- Top 10 Customers 

Select c.full_name,sum(o.total_amount) as total_spent 
from customers c 
Join orders o on customer_id = o.customer_id
where o.order_status in ('Shipped','Delivered')
group by c.customer_id
order by total_spent desc 
limit 10 


-------Best Selling Product 
select 
    p.product_name,
    sum(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_quantity_sold DESC
LIMIT 5;


---Monthly Sales Trend 
Select
    date_format(order_date, '%Y-%m') as month,
    SUM(total_amount) AS monthly_revenue
FROM Orders
WHERE order_status IN ('Shipped', 'Delivered')
GROUP BY month
ORDER BY month;


----Question 2(Analytical Queries) ----------
-----Sales Rank by Category 
SELECT 
    p.category,
    p.product_name,
    SUM(oi.quantity * oi.purchase_price) AS total_revenue,
    RANK() OVER (
        PARTITION BY p.category 
        ORDER BY SUM(oi.quantity * oi.purchase_price) DESC
    ) AS category_rank
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.category;



------ Question 3 
-----Customer Sales Summary 

CREATE VIEW CustomerSalesSummary AS
SELECT 
    c.customer_id,
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
LEFT JOIN Orders o 
    ON c.customer_id = o.customer_id
    AND o.order_status IN ('Shipped', 'Delivered')
GROUP BY c.customer_id;



--------Question 4 
DELIMITER $$

CREATE PROCEDURE ProcessNewOrder(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE current_stock INT DEFAULT 0;
    DECLARE product_price DECIMAL(10,2);

    -- 1. Check stock
    SELECT quantity INTO current_stock 
    FROM Inventory 
    WHERE product_id = p_product_id;

    IF current_stock IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Product does not exist in inventory';
    END IF;

    IF current_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
    END IF;

    -- 2. Get price
    SELECT price INTO product_price
    FROM Products
    WHERE product_id = p_product_id;

    START TRANSACTION;

    -- 3. Create order
    INSERT INTO Orders (customer_id, order_date, total_amount, order_status)
    VALUES (p_customer_id, CURRENT_DATE, product_price * p_quantity, 'Pending');

    -- Get the new order ID
    SET @new_order_id = LAST_INSERT_ID();

    -- 4. Insert into Order_Items
    INSERT INTO Order_Items (order_id, product_id, quantity, purchase_price)
    VALUES (@new_order_id, p_product_id, p_quantity, product_price);

    -- 5. Reduce inventory
    UPDATE Inventory
    SET quantity = quantity - p_quantity
    WHERE product_id = p_product_id;

    COMMIT;
END $$

DELIMITER ;
