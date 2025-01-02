USE magist; 

-- 3.1. In relation to the products:

-- 3.1.1 What categories of tech products does Magist have?
select product_category_name, product_category_name_english
from product_category_name_translation
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%');

-- 3.1.2-A How many products of these tech categories have been sold (within the time window of the database snapshot)?
select count(oi.order_id) AS n_products_solded, pcnt.product_category_name_english
from order_items AS oi
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
JOIN orders AS o ON oi.order_id = o.order_id
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%')
AND order_status = "delivered" or "shipped"
group by product_category_name_english;

-- year 2016
select count(oi.order_id) AS n_products_solded, pcnt.product_category_name_english
from order_items AS oi
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
JOIN orders AS o ON oi.order_id = o.order_id
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%')
AND order_status = "delivered" or "shipped"
AND year(order_purchase_timestamp)=2017
group by product_category_name_english;

-- 3.1.2-B What percentage does that represent from the overall number of products sold? (17150/110197)*100= 15.56%
select count(oi.order_id) AS n_products_solded
from order_items AS oi
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
JOIN orders AS o ON oi.order_id = o.order_id
where order_status = "delivered" or "shipped";
-- ------ ------ overall number of products sold: 110197

select count(oi.order_id) AS n_products_solded
from order_items AS oi
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
JOIN orders AS o ON oi.order_id = o.order_id
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%')
AND order_status = "delivered" or "shipped";
-- ------ ------ number of the tech categories have been sold: 17150


-- 3.1.3 What’s the average price of the products being sold? 119.98 Euro
select avg(price) AS avg_price_products_solded
from order_items AS oi 
JOIN orders AS o ON oi.order_id = o.order_id
WHERE order_status = "delivered" or "shipped";

-- 3.1.3-B The average price of the Tech products being sold? 109.96 Euro
select avg(price) AS avg_price_products_solded
from order_items AS oi 
JOIN orders AS o ON oi.order_id = o.order_id
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%')
AND order_status = "delivered" or "shipped";

-- 3.1.4 Are expensive tech products popular? NO
-- 3.1.4 a) popularity based on ordered items
select avg(price), count(order_id) AS popularity,
CASE 
	when price between 0 AND 100 then "cheap price"
	when price between 100 AND 1000 then "normal price"
	when price > 1000 then "expensive price"
END AS price_category
from order_items AS oi
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%')
group by price_category
order by popularity desc;

-- 3.1.4 b) popularity based on delivered or shipped items
select avg(price), count(oi.order_id) AS popularity,
CASE 
	when price between 0 AND 100 then "cheap price"
	when price between 100 AND 1000 then "normal price"
	when price > 1000 then "expensive price"
END AS price_category
from order_items AS oi
JOIN orders AS o ON oi.order_id = o.order_id
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%')
AND order_status = "delivered" or "shipped"
group by price_category
order by popularity desc;


-- 3.1.2-A How many products of these tech categories have been sold (within the time window of the database snapshot)?
select count(oi.order_id) AS n_products_solded, pcnt.product_category_name_english, year(order_purchase_timestamp)
from order_items AS oi
join products AS p on  oi.product_id=p.product_id
join product_category_name_translation AS pcnt on  p.product_category_name=pcnt.product_category_name
JOIN orders AS o ON oi.order_id = o.order_id
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%')
AND order_status = "delivered" or "shipped"
AND year(order_purchase_timestamp) = '2016'
group by product_category_name_english, year(order_purchase_timestamp);

