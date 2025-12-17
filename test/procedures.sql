CALL ProcessNewOrder(
    1,
    '[
        {"product_id": 1, "quantity": 2},
        {"product_id": 3, "quantity": 1}
    ]'
);


-- 1 row(s) returned


CALL ProcessNewOrder(
    1,
    '[]'
);


--Error Code: 1644. Order must contain at least one item


CALL ProcessNewOrder(
    999,
    '[
        {"product_id": 1, "quantity": 1}
    ]'
);


---Error Code: 1644. Customer does not exist

CALL ProcessNewOrder(
    1,
    '[
        {"product_id": 2, "quantity": 0}
    ]'
);
---Error Code: 1644. Invalid quantity for product 2


