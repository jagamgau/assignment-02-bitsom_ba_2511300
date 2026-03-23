-- Part 3.1 - Star Schema Design

-- Clean-up (optional)
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_date;

-- Date dimension
CREATE TABLE dim_date (
    date_key      INT PRIMARY KEY,     -- e.g. 20230829
    full_date     DATE NOT NULL,
    year          INT NOT NULL,
    month         INT NOT NULL,
    day           INT NOT NULL,
    month_name    VARCHAR(20) NOT NULL
);

-- Store dimension
CREATE TABLE dim_store (
    store_key   INT PRIMARY KEY,
    store_name  VARCHAR(100) NOT NULL,
    store_city  VARCHAR(50) NOT NULL
);

-- Product dimension
CREATE TABLE dim_product (
    product_key   INT PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50) NOT NULL
);

-- Fact table
CREATE TABLE fact_sales (
    sales_key      INT PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL,
    date_key       INT NOT NULL,
    store_key      INT NOT NULL,
    product_key    INT NOT NULL,
    customer_id    VARCHAR(20) NOT NULL,
    units_sold     INT NOT NULL,
    unit_price     DECIMAL(12,2) NOT NULL,
    total_amount   DECIMAL(14,2) NOT NULL,
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- Sample data for dimensions (cleaned and standardized)

-- dim_date
INSERT INTO dim_date (date_key, full_date, year, month, day, month_name) VALUES
(20230829, '2023-08-29', 2023, 8, 29, 'August'),   -- 29/08/2023
(20231212, '2023-12-12', 2023, 12, 12, 'December'),-- 12-12-2023
(20230205, '2023-02-05', 2023, 2, 5, 'February'),  -- 2023-02-05
(20230115, '2023-01-15', 2023, 1, 15, 'January'),  -- 2023-01-15
(20230809, '2023-08-09', 2023, 8, 9, 'August'),    -- 2023-08-09
(20231026, '2023-10-26', 2023, 10, 26, 'October'), -- 2023-10-26
(20231208, '2023-12-08', 2023, 12, 8, 'December'), -- 2023-12-08
(20230604, '2023-06-04', 2023, 6, 4, 'June'),      -- 2023-06-04
(20230521, '2023-05-21', 2023, 5, 21, 'May'),      -- 2023-05-21
(20230111, '2023-01-11', 2023, 1, 11, 'January');  -- 2023-01-11

-- dim_store
INSERT INTO dim_store (store_key, store_name, store_city) VALUES
(1, 'Chennai Anna',   'Chennai'),
(2, 'Delhi South',    'Delhi'),
(3, 'Bangalore MG',   'Bangalore'),
(4, 'Pune FC Road',   'Pune'),
(5, 'Mumbai Central', 'Mumbai');

-- dim_product (categories standardized with consistent casing)
INSERT INTO dim_product (product_key, product_name, category) VALUES
(1, 'Speaker',    'Electronics'),
(2, 'Tablet',     'Electronics'),
(3, 'Phone',      'Electronics'),
(4, 'Smartwatch', 'Electronics'),
(5, 'Atta 10kg',  'Grocery'),
(6, 'Jeans',      'Clothing'),
(7, 'Biscuits',   'Grocery'),
(8, 'Jacket',     'Clothing'),
(9, 'Laptop',     'Electronics'),
(10,'Milk 1L',    'Grocery');

-- fact_sales (10 cleaned sample rows based on retail_transactions.csv)

INSERT INTO fact_sales (
    sales_key, transaction_id, date_key, store_key, product_key,
    customer_id, units_sold, unit_price, total_amount
) VALUES
-- TXN5000,29/08/2023,Chennai Anna,Chennai,Speaker,electronics,3,49262.78,CUST045
(1, 'TXN5000', 20230829, 1, 1, 'CUST045', 3, 49262.78, 3 * 49262.78),

-- TXN5001,12-12-2023,Chennai Anna,Chennai,Tablet,Electronics,11,23226.12,CUST021
(2, 'TXN5001', 20231212, 1, 2, 'CUST021', 11, 23226.12, 11 * 23226.12),

-- TXN5002,2023-02-05,Chennai Anna,Chennai,Phone,Electronics,20,48703.39,CUST019
(3, 'TXN5002', 20230205, 1, 3, 'CUST019', 20, 48703.39, 20 * 48703.39),

-- TXN5004,2023-01-15,Chennai Anna,Chennai,Smartwatch,electronics,10,58851.01,CUST004
(4, 'TXN5004', 20230115, 1, 4, 'CUST004', 10, 58851.01, 10 * 58851.01),

-- TXN5005,2023-08-09,Bangalore MG,Bangalore,Atta 10kg,Grocery,12,52464.0,CUST027
(5, 'TXN5005', 20230809, 3, 5, 'CUST027', 12, 52464.00, 12 * 52464.00),

-- TXN5007,2023-10-26,Pune FC Road,Pune,Jeans,Clothing,16,2317.47,CUST041
(6, 'TXN5007', 20231026, 4, 6, 'CUST041', 16, 2317.47, 16 * 2317.47),

-- TXN5008,2023-12-08,Bangalore MG,Bangalore,Biscuits,Groceries,9,27469.99,CUST030
(7, 'TXN5008', 20231208, 3, 7, 'CUST030', 9, 27469.99, 9 * 27469.99),

-- TXN5010,2023-06-04,Chennai Anna,Chennai,Jacket,Clothing,15,30187.24,CUST031
(8, 'TXN5010', 20230604, 1, 8, 'CUST031', 15, 30187.24, 15 * 30187.24),

-- TXN5012,2023-05-21,Bangalore MG,Bangalore,Laptop,Electronics,13,42343.15,CUST044
(9, 'TXN5012', 20230521, 3, 9, 'CUST044', 13, 42343.15, 13 * 42343.15),

-- TXN5013,28-04-2023,Mumbai Central,Mumbai,Milk 1L,Groceries,10,43374.39,CUST015
-- cleaned date assumed as 2023-04-28 -> 20230428
(10,'TXN5013', 20230428, 5, 10, 'CUST015', 10, 43374.39, 10 * 43374.39);

