use olist;
----Q1----
select price from order_items
order by price DESC
LIMIT 1;

select price from order_items
order by price ASC
LIMIT 1;

---Q2-----
select min(shipping_limit_date) from order_items;
select max(shipping_limit_date) from order_items;

----Q3----;

select customer_state, count(customer_unique_id) from customers
group by customer_state
order by count(customer_unique_id) DESC;
-OR-
select customer_state, count(customer_id) from customers
group by customer_state
order by count(customer_id) DESC;

----Q4----;

select customer_city, customer_state, count(customer_id) from customers
where customer_state in ('SP')
group by customer_city
order by count(customer_id) DESC;

----Q5----;
SELECT count(DISTINCT business_segment) FROM closed_deals;

select business_segment from closed_deals
group by business_segment;

----Q6-----;
 
 SELECT business_segment, sum(declared_monthly_revenue) FROM closed_deals
 group by business_segment
 order by sum(declared_monthly_revenue) desc
 limit 3;
 
 -----Q7-----;
 
 SELECT count(DISTINCT review_score) FROM order_reviews;
 
  -----Q8-----;
   
ALTER TABLE order_reviews
ADD review_category varchar(255);

SELECT * FROM order_reviews;

SET SQL_SAFE_UPDATES = 0;

UPDATE order_reviews
SET review_category = "VERY BAD"
WHERE review_score = 1;

UPDATE order_reviews
SET review_category = "BAD"
WHERE review_score = 2;

UPDATE order_reviews
SET review_category = "AVERAGE"
WHERE review_score = 3;

UPDATE order_reviews
SET review_category = "GOOD"
WHERE review_score = 4;

UPDATE order_reviews
SET review_category = "VERY GOOD"
WHERE review_score = 5;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM order_reviews;

SELECT review_category, review_score, Count(review_id) FROM order_reviews
GROUP BY review_category, review_score
ORDER BY Count(review_id) DESC;

----Q9-----;

SELECT review_score, Count(review_id) FROM order_reviews
GROUP BY review_score
ORDER BY Count(review_id) DESC;

SELECT review_score, Count(review_score) FROM order_reviews
GROUP BY review_score
ORDER BY Count(review_id) DESC;