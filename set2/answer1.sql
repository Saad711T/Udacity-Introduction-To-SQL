select 
EXTRACT(YEAR FROM r.rental_date) AS rental_year, EXTRACT(MONTH FROM r.rental_date) AS rental_month, i.store_id,
COUNT(r.rental_id) AS count_rentals
from  
rental r
join 
inventory i ON r.inventory_id = i.inventory_id
GROUP BY 
rental_year, rental_month, i.store_id
ORDER BY 
rental_year, rental_month, i.store_id;