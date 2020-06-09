WITH newfilmtable AS (
    SELECT f.title filmtitle, c.name categoryname
         FROM film_category fc 
         JOIN category c
         ON fc.category_id = c.category_id
         JOIN film f 
         ON f.film_id = fc.film_id 
         JOIN inventory i 
         ON i.film_id = f.film_id 
         JOIN rental r
         ON r.inventory_id = i.inventory_id
          )
          
	SELECT filmtitle, categoryname, count(*)
		FROM newfilmtable
	WHERE categoryname IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	GROUP by 1,2
	ORDER by 2,1;
         
		 
WITH newfilmtable AS (
	SELECT f.title movietitle, c.name moviename, f.rental_duration rentalduration
		FROM film_category fc 
		JOIN category c 
		ON fc.category_id = c.category_id 
		JOIN film f 
		ON f.film_id = fc.film_id 
	)
	SELECT movietitle, moviename, rentalduration, 
			NTILE(4) OVER (ORDER BY rentalduration) AS standard_quartile
		FROM newfilmtable
	WHERE moviename IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	ORDER BY 3;	


WITH newfilmtable AS (
	SELECT f.title movietitle, c.name moviename, f.rental_duration rentalduration
		FROM film_category fc 
		JOIN category c 
		ON fc.category_id = c.category_id 
		JOIN film f 
		ON f.film_id = fc.film_id 
   ),
newfilmtable2 AS (
	SELECT moviename, rentalduration,
			NTILE(4) OVER (ORDER BY rentalduration) AS standard_quartile
		FROM newfilmtable
	WHERE moviename IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
 )
 
	SELECT moviename, standard_quartile, COUNT(standard_quartile)
		FROM newfilmtable2
	GROUP BY 1,2
	ORDER BY 1,2;
 
WITH newtable AS (
	SELECT customer_id, SUM(amount) AS pay_amount
		FROM payment
	WHERE payment_date BETWEEN '2007-01-01 '::DATE AND '2007-12-31'::DATE
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10
  )
	SELECT Date_trunc('Month',p.payment_date) as pay_mon,
			c.first_name || ' ' || c.last_name AS full_name,
			COUNT(*) as pay_countperson, 
			SUM(p.amount) AS pay_amount
		FROM customer c 
		JOIN payment p 
		ON c.customer_id = p.customer_id
	WHERE p.customer_id IN 
	( SELECT customer_id FROM newtable )
	GROUP BY 1,2
	ORDER BY 2;
 
   
    
         

 