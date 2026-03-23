-- Q1: Total sales revenue by product category for each month
SELECT
    d.year,
    d.month,
    d.month_name,
    p.category,
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY
    d.year,
    d.month,
    d.month_name,
    p.category
ORDER BY
    d.year,
    d.month,
    p.category;

-- Q2: Top 2 performing stores by total revenue
SELECT
    s.store_name,
    s.store_city,
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_store s
    ON f.store_key = s.store_key
GROUP BY
    s.store_name,
    s.store_city
ORDER BY
    total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;
