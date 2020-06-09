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