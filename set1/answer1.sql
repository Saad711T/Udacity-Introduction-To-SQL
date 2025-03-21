SELECT 
    f.title AS Movie,
    c.name AS Category,
    COUNT(r.rental_id) AS Rental_Count
FROM
    film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE
    c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY
    f.title, c.name
ORDER BY
    c.name, f.title;