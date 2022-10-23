use publications;

select count(title_id) from titleauthor;

SELECT a.au_id, a.au_lname, a.au_fname, ti.title, p.pub_name FROM titleauthor t
LEFT JOIN authors a
ON t.au_id = a.au_id
LEFT JOIN titles ti
ON t.title_id = ti.title_id
LEFT JOIN publishers p
ON ti.pub_id = p.pub_id
ORDER BY au_id;

---------q2--------------;

SELECT a.au_id, a.au_lname, a.au_fname, count(ti.title), p.pub_name FROM titleauthor t
LEFT JOIN authors a
ON t.au_id = a.au_id
LEFT JOIN titles ti
ON t.title_id = ti.title_id
LEFT JOIN publishers p
ON ti.pub_id = p.pub_id
GROUP BY au_id, pub_name
ORDER BY count(ti.title) DESC, Au_ID DESC

---------q3--------------------;

SELECT a.au_id, a.au_lname, a.au_fname, Sum(s.qty) FROM titleauthor t
LEFT JOIN authors a
ON t.au_id = a.au_id
LEFT JOIN sales s
ON t.title_id = s.title_id
GROUP BY Au_ID
ORDER BY Sum(s.qty) DESC
limit 3;

--------q4---------------------;

SELECT a.au_id, a.au_lname, a.au_fname, IF (Sum(s.qty), Sum(s.qty), 0) as salestot FROM titleauthor t
LEFT JOIN authors a
ON t.au_id = a.au_id
LEFT JOIN sales s
ON t.title_id = s.title_id
GROUP BY Au_ID
ORDER BY salestot DESC;
