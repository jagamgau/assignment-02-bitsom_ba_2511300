-- Part 1.2 - Schema Design

-- Clean-up (optional, for reruns)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS sales_reps;

-- Customers table
CREATE TABLE customers (
    customer_id     VARCHAR(10) PRIMARY KEY,
    customer_name   VARCHAR(100) NOT NULL,
    customer_email  VARCHAR(100) NOT NULL,
    customer_city   VARCHAR(50) NOT NULL
);

-- Products table
CREATE TABLE products (
    product_id    VARCHAR(10) PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50) NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL
);

-- Sales representatives table
CREATE TABLE sales_reps (
    sales_rep_id    VARCHAR(10) PRIMARY KEY,
    sales_rep_name  VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address  VARCHAR(255) NOT NULL
);

-- Orders table (one row per order)
CREATE TABLE orders (
    order_id     VARCHAR(20) PRIMARY KEY,
    order_date   DATE NOT NULL,
    customer_id  VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

-- Order items table (one row per product in an order)
CREATE TABLE order_items (
    order_id   VARCHAR(20) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity   INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data: customers
INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi'),
('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore'),
('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi'),
('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore'),
('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');

-- Sample data: products
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop',        'Electronics', 55000),
('P002', 'Mouse',         'Electronics', 800),
('P003', 'Desk Chair',    'Furniture',   8500),
('P004', 'Notebook',      'Stationery',  120),
('P005', 'Headphones',    'Electronics', 3200),
('P006', 'Standing Desk', 'Furniture',   22000),
('P007', 'Pen Set',       'Stationery',  250),
('P008', 'Webcam',        'Electronics', 2100);

-- Sample data: sales reps
INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');

-- Sample data: orders
INSERT INTO orders (order_id, order_date, customer_id, sales_rep_id) VALUES
('ORD1027', '2023-11-02', 'C002', 'SR02'),
('ORD1114', '2023-08-06', 'C001', 'SR01'),
('ORD1075', '2023-04-18', 'C005', 'SR03'),
('ORD1061', '2023-10-27', 'C006', 'SR01'),
('ORD1098', '2023-10-03', 'C007', 'SR03'),
('ORD1131', '2023-06-22', 'C008', 'SR02');

-- Sample data: order items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
('ORD1027', 'P004', 4, 120),
('ORD1114', 'P007', 2, 250),
('ORD1075', 'P003', 3, 8500),
('ORD1061', 'P001', 4, 55000),
('ORD1098', 'P001', 2, 55000),
('ORD1131', 'P001', 4, 55000);
