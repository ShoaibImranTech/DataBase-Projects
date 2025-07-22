CREATE DATABASE DataPulseDB;
USE DataPulseDB;
-- Customers Table
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  gender VARCHAR(10),
  age INT,
  city VARCHAR(100),
  joined_date DATE
);

-- Products Table
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10, 2),
  stock INT
);

-- Orders Table
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date DATE,
  status VARCHAR(20)
);

-- Order Details
CREATE TABLE order_details (
  order_detail_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  product_id INT REFERENCES products(product_id),
  quantity INT,
  total_price DECIMAL(10, 2)
);
-- Top-Selling Products
SELECT 
  p.name AS product_name,
  SUM(od.quantity) AS total_units_sold,
  SUM(od.total_price) AS revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.name
ORDER BY revenue DESC
LIMIT 5;

--  Customer Segmentation by Age
SELECT 
  CASE 
    WHEN age < 20 THEN 'Teenagers'
    WHEN age BETWEEN 20 AND 35 THEN 'Young Adults'
    WHEN age BETWEEN 36 AND 50 THEN 'Middle-Aged'
    ELSE 'Seniors'
  END AS age_group,
  COUNT(*) AS total_customers
FROM customers
GROUP BY age_group;

-- Top Cities by Order Volume
SELECT 
c.city,
COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_orders DESC
LIMIT 5;

-- Sales Trend by Month
SELECT 
  TO_CHAR(order_date, 'Month') AS month,
  SUM(od.total_price) AS monthly_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY TO_CHAR(order_date, 'Month')
ORDER BY MIN(order_date);

-- Low Stock Alerts
SELECT 
  product_id, name, stock
FROM products
WHERE stock < 10
ORDER BY stock ASC;

