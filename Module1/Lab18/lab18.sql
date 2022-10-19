create database if not exists applestore;
select * from applestore;

select prime_genre from applestore
group by prime_genre
order by rating_count_tot DESC;

select prime_genre from applestore
group by prime_genre
order by prime_genre DESC;

select prime_genre from applestore
group by prime_genre
order by prime_genre ASC;

select track_name from applestore
order by rating_count_tot DESC
LIMIT 10;

select track_name from applestore
order by user_rating DESC
LIMIT 10;

select track_name from applestore 
order by user_rating DESC, rating_count_tot DESC 
limit 3;

SELECT prime_genre, track_name, user_rating, rating_count_tot from applestore
ORDER BY user_rating DESC, rating_count_tot DESC
LIMIT 3;
