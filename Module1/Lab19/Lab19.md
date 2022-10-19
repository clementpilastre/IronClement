#### 1. From the `order_items` table, find the price of the highest priced order and lowest price order.


```python
select price from order_items
order by price DESC
LIMIT 1;

select price from order_items
order by price ASC
LIMIT 1;
```

according to the result of the previous query :
    
the price of the highest priced order is 6735
the price of the lowest price order is 0.85 

#### 2. From the `order_items` table, what is range of the shipping_limit_date of the orders?


```python
select min(shipping_limit_date) from order_items;

select max(shipping_limit_date) from order_items;
```


```python
according to the result of the previous query :

the range goes from 2016-09-19 02:15:34 to 2020-04-10 00:35:08
```

#### 3. From the `customers` table, find the states with the greatest number of customers.


```python
select customer_state, count(customer_unique_id) from customers
group by customer_state
order by count(customer_unique_id) DESC;

-OR-

select customer_state, count(customer_id) from customers
group by customer_state
order by count(customer_id) DESC;
```


```python
according to the result of the previous query the states with the most customers :

SP	41746
RJ	12852
MG	11635
```

#### 4. From the `customers` table, within the state with the greatest number of customers, find the cities with the greatest number of customers.


```python
select customer_city, customer_state, count(customer_id) from customers
where customer_state in ('SP')
group by customer_city
order by count(customer_id) DESC;
```


```python
According to the previous query the cities with the most customers is :
    
sao paulo	SP	15540
campinas	SP	1444
guarulhos	SP	1189
```

#### 5. From the `closed_deals` table, how many distinct business segments are there (not including null)?


```python
SELECT count(DISTINCT business_segment) FROM closed_deals;

AND

select business_segment, from closed_deals
group by business_segment;


```


```python
According to the previous query the cities with the most customers is :

There 32 business segments, including 1 called "Other" (33 in the answer to the query minus the category "NULL" verified in the second query)
```

#### 6. From the `closed_deals` table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).


```python
select business_segment, sum(declared_monthly_revenue) from closed_deals
group by business_segment
order by sum(declared_monthly_revenue) desc
limit 3;
```


```python
According to the previous query the 3 biggest segments are :

construction_tools_house_garden
phone_mobile
home_decor
```

#### 7. From the `order_reviews` table, find the total number of distinct review score values.


```python
SELECT count(DISTINCT review_score) FROM order_reviews;
```

According to the previous query the total number of distinct review score values are :
5

 #### 8. In the `order_reviews` table, create a new column with a description that corresponds to each number category 
 for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.;


```python
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
```


```python
5	57420	very good
4	19200	good
1	11858	very bad
3	8287	middle
2	3235	bad
```

#### 9. From the `order_reviews` table, find the review value occurring most frequently and how many times it occurs.


```python
SELECT review_score, Count(review_score) FROM order_reviews
GROUP BY review_score
ORDER BY Count(review_id) DESC;
```


```python
5	57420
```
