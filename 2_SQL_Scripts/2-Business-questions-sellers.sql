USE magist; 

-- 3.2. In relation to the sellers: 

-- 3.2.1 How many months of data are included in the magist database? 25 months
SELECT distinct(TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp))) AS months_of_data
FROM orders;

-- 3.2.2-A How many sellers are there? 3095 sellers
select count(distinct seller_id)
from sellers;

-- 3.2.2-B How many Tech sellers are there? 486 Tech sellers
select count(distinct oi.seller_id)
from order_items AS oi
join products AS p on oi.product_id=p.product_id
join product_category_name_translation AS pcnt on p.product_category_name=pcnt.product_category_name
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%');

-- 3.2.2-C What percentage of overall sellers are Tech sellers? 
-- (486/3095)*100=15.7%

-- 3.2.3-A What is the total amount earned by all sellers? Total_earned: 16008872.139586091
select sum(payment_value) AS total_earned
from order_payments;

-- 3.2.3-B What is the total amount earned by all Tech sellers? Total_earned_by_Tech_sellers: 3086223.921149602
select sum(op.payment_value) AS Total_earned_by_Tech_sellers
from sellers AS s
join order_items AS oi ON s.seller_id=oi.seller_id
join order_payments AS op ON oi.order_id=op.order_id
join products AS p on oi.product_id=p.product_id
join product_category_name_translation AS pcnt on p.product_category_name=pcnt.product_category_name
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%');

-- 3.2.4-A Can you work out the average monthly income of all sellers? avg_monthly_income: 882962.3853667789
select sum(op.payment_value) AS Total_earned, 
TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)) AS n_month,
sum(op.payment_value)/(TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp))) AS avg_monthly_income
from sellers AS s
join order_items AS oi ON s.seller_id=oi.seller_id
join order_payments AS op ON oi.order_id=op.order_id
join orders AS o ON oi.order_id=o.order_id;

-- 3.2.4-AA Can you work out the average monthly income of each sellers?
select s.seller_id, sum(op.payment_value) AS Total_earned, 
TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)) AS n_month, 
sum(op.payment_value)/(TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp))) AS avg_monthly_income
from sellers AS s
join order_items AS oi ON s.seller_id=oi.seller_id
join order_payments AS op ON oi.order_id=op.order_id
join orders AS o ON oi.order_id=o.order_id
group by s.seller_id;

-- 3.2.4-B Can you work out the average monthly income of Tech sellers? avg_monthly_tech_income: 134183.64874563488
select sum(op.payment_value) AS Total_earned, 
TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)) AS n_month,
sum(op.payment_value)/(TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp))) AS avg_monthly_tech_income
from sellers AS s
join order_items AS oi ON s.seller_id=oi.seller_id
join order_payments AS op ON oi.order_id=op.order_id
join orders AS o ON oi.order_id=o.order_id
join products AS p on oi.product_id=p.product_id
join product_category_name_translation AS pcnt on p.product_category_name=pcnt.product_category_name
where product_category_name_english like ('%electronic%') 
or product_category_name_english like ('%technolog%') 
or product_category_name_english like ('%computer%') 
or product_category_name_english like ('%software%')
or product_category_name_english like ('%information%')
or product_category_name_english like ('%tele%')
or product_category_name_english like ('%audio%')
or product_category_name_english like ('%tablet%')
or product_category_name_english like ('%game%');