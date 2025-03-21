WITH t2
AS (SELECT
  c.name,
  f.rental_duration,
  NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile

FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id

JOIN film AS f
  ON fc.film_id = f.film_id

WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))

SELECT
  name,
  standard_quartile,
  COUNT(standard_quartile)
FROM t2

GROUP BY 1,
         2
ORDER BY 1, 2;