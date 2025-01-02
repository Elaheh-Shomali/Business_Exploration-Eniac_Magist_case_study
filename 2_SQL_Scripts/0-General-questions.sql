USE magist; 

-- General questions:
select *
from orders;

-- 1. How many orders are there in the dataset?
SELECT COUNT(*) AS orders_count
FROM orders;

-- 2. Are orders actually delivered? (ship are maybe lost)
select count(*) AS total_orders, order_status
from orders
group by order_status
order by total_orders desc;

-- 3. Is Magist having user growth? 
select count(order_id), year(order_purchase_timestamp) AS order_year, month(order_purchase_timestamp) AS order_month
from orders
group by order_year, order_month
order by order_year, order_month;

-- 4. How many products are there on the products table? 
select *
from products;

select count(distinct product_id) AS products_count
from products;

-- 5. Which are the categories with the most products? 
select count(distinct product_id) AS n_product_category, product_category_name
from products
group by product_category_name
order by n_product_category desc;

-- 6. How many of those products were present in actual transactions? 111382
select * 
from order_items;

select count(distinct product_id) 
from order_items;

select  count(product_id)
from order_items AS oi
join orders AS o ON oi.order_id=o.order_id
where order_status='delivered'
OR order_status='shipped';

select  count(oi.order_id)
from order_items AS oi
join orders AS o ON oi.order_id=o.order_id
where order_status='delivered'
OR order_status='shipped';

select count(oi.order_id)
from order_items AS oi 
JOIN orders AS o ON oi.order_id = o.order_id
where order_status='delivered' OR order_status='shipped';

select count(oi.order_id)
from order_items AS oi 
JOIN orders AS o ON oi.order_id = o.order_id
WHERE order_status = "delivered" or "shipped";

-- 7. What’s the price for the most expensive and cheapest products? 
select max(price) AS most_expensive, min(price) AS cheapest
from order_items;

-- 8. What are the highest and lowest payment values?
select max(payment_value) AS highest_payment, min(payment_value) AS lowest_payment
from order_payments;

-- from solutions
SELECT
    SUM(payment_value) AS highest_order
FROM
    order_payments
GROUP BY
    order_id
ORDER BY
    highest_order DESC
LIMIT
    1;
