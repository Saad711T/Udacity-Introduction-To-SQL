WITH T1 AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS fullname,
        EXTRACT(YEAR FROM p.payment_date) AS payment_year,
        EXTRACT(MONTH FROM p.payment_date) AS payment_month,
        SUM(p.amount) AS total_monthly_payment
    FROM 
        payment p
    JOIN 
        rental r ON p.rental_id = r.rental_id
    JOIN 
        customer c ON r.customer_id = c.customer_id
    WHERE 
        EXTRACT(YEAR FROM p.payment_date) = 2007
    GROUP BY 
        c.customer_id, payment_year, payment_month
), TopCustomers AS (
    SELECT 
        customer_id,
        SUM(total_monthly_payment) AS total_yearly_payment
    FROM 
        T1
    GROUP BY 
        customer_id
    ORDER BY 
        total_yearly_payment DESC
    LIMIT 10
)
SELECT 
    cp.fullname,
    cp.payment_month,
    cp.payment_year,
    COUNT(*) AS number_of_payments,
    SUM(cp.total_monthly_payment) AS total_monthly_amount
FROM 
    T1 cp
JOIN 
    TopCustomers tc ON cp.customer_id = tc.customer_id
GROUP BY 
    cp.fullname, cp.payment_month, cp.payment_year
ORDER BY 
    cp.fullname, cp.payment_year, cp.payment_month;
