CREATE INDEX idx_orders_customer
    ON Orders(customer_id);

CREATE INDEX idx_order_items_product
    ON Order_Items(product_id);
