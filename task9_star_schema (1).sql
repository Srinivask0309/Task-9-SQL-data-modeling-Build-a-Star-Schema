
-- TASK 9: STAR SCHEMA DATA MODEL
-- Database: PostgreSQL / MySQL compatible

-- =====================
-- DIMENSION TABLES
-- =====================

CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

CREATE TABLE dim_region (
    region_id SERIAL PRIMARY KEY,
    region VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    order_date DATE,
    year INT,
    month INT,
    day INT
);

-- =====================
-- FACT TABLE
-- =====================

CREATE TABLE fact_sales (
    sales_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    region_id INT,
    date_id INT,
    sales NUMERIC(10,2),
    quantity INT,
    profit NUMERIC(10,2),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

-- =====================
-- INDEXES
-- =====================

CREATE INDEX idx_customer ON fact_sales(customer_id);
CREATE INDEX idx_product ON fact_sales(product_id);
CREATE INDEX idx_region ON fact_sales(region_id);
CREATE INDEX idx_date ON fact_sales(date_id);

-- =====================
-- ANALYTICAL QUERY
-- =====================

-- Total sales by category
SELECT p.category, SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category;
