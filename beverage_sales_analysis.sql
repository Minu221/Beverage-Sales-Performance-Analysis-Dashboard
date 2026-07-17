-- Tạo bảng dữ liệu
CREATE TABLE beverage_sales (
	order_id VARCHAR(20),
    customer_id VARCHAR(20),
    customer_type VARCHAR(10),
    product VARCHAR(100),
    category VARCHAR(50),
    unit_price NUMERIC(10,2),
    quantity INTEGER,
    discount NUMERIC(5,2),
    total_price NUMERIC(12,2),
    region VARCHAR(100),
    order_date DATE
);

-- Hiển thị mẫu 5 dòng dữ liệu
SELECT * FROM beverage_sales
LIMIT 5;

-- How did the company's KPIs change over the years?
SELECT EXTRACT(YEAR FROM order_date) as year,
	   COUNT(order_id) as total_order,
	   COUNT(DISTINCT customer_id) as total_customer, 
	   SUM(total_price) as total_revenue,
	   SUM(quantity) as total_quantity,
	   AVG(discount) as avg_discount,
	   AVG(total_price) as avg_order_value
FROM beverage_sales
GROUP BY year;

-- How has monthly orders and revenue changed over time?
SELECT EXTRACT(YEAR FROM order_date) AS year,
    	EXTRACT(MONTH FROM order_date) AS month,
    	COUNT(order_id) AS total_orders,
    	SUM(total_price) AS total_revenue
FROM beverage_sales
GROUP BY year, month
ORDER BY year, month;

-- TOP10 products generate the highest sales?
SELECT product,
    	SUM(quantity) AS total_quantity,
    	SUM(total_price) AS total_revenue
FROM beverage_sales
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 10;

-- TOP10 regions contribute the most revenue?
SELECT region,
    	SUM(total_price) AS total_revenue
FROM beverage_sales
GROUP BY region
ORDER BY total_revenue DESC
LIMIT 10;

-- Do B2B customers generate more revenue than B2C customers?
SELECT customer_type,
    	COUNT(order_id) AS total_orders,
    	SUM(total_price) AS total_revenue,
    	AVG(total_price) AS average_order_value
FROM beverage_sales
GROUP BY customer_type;

-- Does offering discounts increase revenue?
SELECT discount,
    	COUNT(order_id) AS total_orders,
    	SUM(quantity) AS total_quantity,
    	SUM(total_price) AS total_revenue
FROM beverage_sales
GROUP BY discount;