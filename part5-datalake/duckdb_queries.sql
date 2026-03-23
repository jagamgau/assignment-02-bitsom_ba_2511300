-- Q1: List all customers along with the total number of orders they have placed
WITH customers AS (
    SELECT * FROM read_csv_auto('customers.csv')
),
orders AS (
    SELECT * FROM read_json_auto('orders.json')
)
SELECT
    c.customer_id,
    c.name,
    c.city,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name,
    c.city
ORDER BY
    c.customer_id;

-- Q2: Find the top 3 customers by total order value
WITH customers AS (
    SELECT * FROM read_csv_auto('customers.csv')
),
orders AS (
    SELECT * FROM read_json_auto('orders.json')
)
SELECT
    c.customer_id,
    c.name,
    c.city,
    SUM(o.total_amount) AS total_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name,
    c.city
ORDER BY
    total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
WITH customers AS (
    SELECT * FROM read_csv_auto('customers.csv')
),
orders AS (
    SELECT * FROM read_json_auto('orders.json')
),
products AS (
    SELECT * FROM read_parquet('products.parquet')
)
SELECT DISTINCT
    p.product_id,
    p.product_name,
    p.category
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
WHERE c.city = 'Bangalore'
ORDER BY
    p.product_name;

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
WITH customers AS (
    SELECT * FROM read_csv_auto('customers.csv')
),
orders AS (
    SELECT * FROM read_json_auto('orders.json')
),
products AS (
    SELECT * FROM read_parquet('products.parquet')
)
SELECT
    c.name         AS customer_name,
    o.order_date   AS order_date,
    p.product_name AS product_name,
    o.num_items    AS quantity
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id
ORDER BY
    o.order_date,
    c.name;
