USE magist; 

-- 3.3. In relation to the delivery time:

-- 3.3.1 What’s the average time between the order being placed and the product being delivered? Average: 12.5030 
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS date_difference
FROM orders
WHERE order_purchase_timestamp IS NOT NULL AND order_delivered_customer_date IS NOT NULL
AND order_status = "delivered" OR "shipped";

SELECT order_id, order_delivered_customer_date, order_purchase_timestamp, DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS date_difference
FROM orders
WHERE order_purchase_timestamp IS NOT NULL AND order_delivered_customer_date IS NOT NULL
AND order_status = "delivered" OR "shipped"
ORDER BY date_difference desc;

-- 3.3.2 How many orders are delivered on time vs orders delivered with a delay? Orders delivered on time: 96470 
SELECT COUNT(DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)) AS estimated_difference
FROM orders
WHERE order_status = "delivered"
Having estimated_difference > 12;

-- To show estimated_difference: Positive numbers (+) are delayed & Negative numbers (-) are earlier & 0 numbers are on time
SELECT order_id, order_delivered_customer_date, order_estimated_delivery_date, 
DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS estimated_difference
FROM orders
WHERE order_status = "delivered" AND order_purchase_timestamp IS NOT NULL AND order_delivered_customer_date IS NOT NULL;

-- 3.3.3 Is there any pattern for delayed orders, e.g. big products being delayed more often?
SELECT p.product_category_name, p. product_weight_g, 
o.order_id, o.order_delivered_customer_date, o.order_estimated_delivery_date, 
DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS estimated_difference
FROM orders AS o 
LEFT JOIN order_items as oi ON o.order_id = oi.order_id 
JOIN products AS p ON oi.product_id = p.product_id
WHERE (order_status = "delivered" OR "shipped") AND 
order_purchase_timestamp IS NOT NULL AND order_delivered_customer_date IS NOT NULL
order by product_weight_g desc;