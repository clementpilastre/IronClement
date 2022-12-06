use publications;
-- CHALLENGE 1
-- STEP 1
SELECT titles.title_id, au_id, titles.advance * titleauthor.royaltyper /100 as advance,
titles.price* sales.qty * titles.royalty/100 * titleauthor.royaltyper/100 as royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON  titleauthor.title_id = sales.title_id;

-- STEP 2
SELECT count(DISTINCT title_id) FROM
(SELECT titles.title_id, au_id, titles.advance * titleauthor.royaltyper /100 as advance,
titles.price* sales.qty * titles.royalty/100 * titleauthor.royaltyper/100 as royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON  titleauthor.title_id = sales.title_id)
as step1;

SELECT title_id, au_id, advance, sum(royalty) as agg_royalties
FROM 
(SELECT titles.title_id, au_id, titles.advance * titleauthor.royaltyper /100 as advance,
titles.price* sales.qty * titles.royalty/100 * titleauthor.royaltyper/100 as royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON  titleauthor.title_id = sales.title_id)
as step1
GROUP BY title_id, au_id;

-- STEP 3
SELECT count(DISTINCT au_id) FROM
(SELECT titles.title_id, au_id, titles.advance * titleauthor.royaltyper /100 as advance,
titles.price* sales.qty * titles.royalty/100 * titleauthor.royaltyper/100 as royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON  titleauthor.title_id = sales.title_id)
as step1;


SELECT au_id, sum(advance + agg_royalties) as profits
FROM
(SELECT title_id, au_id, advance, sum(royalty) as agg_royalties
FROM 
(SELECT titles.title_id, au_id, titles.advance * titleauthor.royaltyper /100 as advance,
titles.price* sales.qty * titles.royalty/100 * titleauthor.royaltyper/100 as royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON  titleauthor.title_id = sales.title_id)
as step1
GROUP BY title_id, au_id)
as step2
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;

-- CHALLENGE 2
-- STEP 1
Create temporary table step1
SELECT titles.title_id, au_id, titles.advance * titleauthor.royaltyper /100 as advance,
titles.price* sales.qty * titles.royalty/100 * titleauthor.royaltyper/100 as royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON  titleauthor.title_id = sales.title_id;

-- SETP 2
Create temporary table step2
SELECT title_id, au_id, advance, sum(royalty) as agg_royalties
FROM step1
GROUP BY title_id, au_id;

-- STEP 3
SELECT au_id, sum(advance + agg_royalties) as profits
FROM
step2
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;

-- CHALLENGE 3
CREATE TABLE most_profiting_authors 
SELECT au_id, sum(advance + agg_royalties) as profits
FROM
step2
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3; 