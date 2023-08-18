-- Total number os Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Average order pric
SELECT ROUND(AVG(od.quantity * p.price), 2) AS avg_order_price
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

-- Top 10 most popular pizza types
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 10;

-- Most pizzas ordered in a day
SELECT date, COUNT(*) AS total_orders
FROM orders
GROUP BY date
ORDER BY total_orders DESC
LIMIT 1;

-- Revenue by pizza category
SELECT pt.category, SUM(od.quantity * p.price) AS revenue
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- Top Selling Pizzas by Quantity
SELECT p.pizza_id, pt.name, SUM(od.quantity) AS total_quantity
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.pizza_id, pt.name
ORDER BY total_quantity DESC
LIMIT 10;

-- Total orders per month
SELECT EXTRACT(MONTH FROM date) AS month, COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- Total revenue per month
SELECT EXTRACT(MONTH FROM o.date) AS month, SUM(od.quantity * p.price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY month
ORDER BY month;

-- Top Selling Pizza Type per Month
SELECT EXTRACT(MONTH FROM o.date) AS month, pt.name, SUM(od.quantity) AS total_quantity
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY month, pt.name
ORDER BY month, total_quantity DESC;

-- Busiest Month
SELECT EXTRACT(MONTH FROM date) AS month, COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY total_orders DESC
LIMIT 1;

-- Average Order Quantity and Price by Month
SELECT EXTRACT(MONTH FROM o.date) AS month,
       ROUND(AVG(od.quantity), 2) AS avg_order_quantity,
       ROUND(AVG(od.quantity * p.price), 2) AS avg_order_price
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY month
ORDER BY month;

-- Most Expensive order
SELECT EXTRACT(MONTH FROM o.date) AS month,
       o.order_id,
       SUM(od.quantity * p.price) AS total_price
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY month, o.order_id
ORDER BY month, total_price DESC
LIMIT 1;

-- Orders Count Comparison between Weekends and Weekdays
SELECT CASE WHEN EXTRACT(DOW FROM date) IN (0, 6) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
       COUNT(*) AS total_orders
FROM orders
GROUP BY day_type;

-- Average Order Quantity and Price on Weekends and Weekdays
SELECT CASE WHEN EXTRACT(DOW FROM o.date) IN (0, 6) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
       AVG(od.quantity) AS avg_order_quantity,
       AVG(od.quantity * p.price) AS avg_order_price
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY day_type;

-- Top Selling Pizza Type on Weekends and Weekdays
SELECT CASE WHEN EXTRACT(DOW FROM o.date) IN (0, 6) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
       pt.name, SUM(od.quantity) AS total_quantity
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY day_type, pt.name
ORDER BY day_type, total_quantity DESC;

-- Total Orders by Pizza Size
SELECT p.size, COUNT(*) AS total_orders
FROM pizzas p
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.size;

-- Revenue by Pizza Size
SELECT p.size, SUM(od.quantity * p.price) AS revenue
FROM pizzas p
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY revenue DESC;

-- Time-of-Day Analysis: Orders by Hour:
SELECT EXTRACT(HOUR FROM o.time) AS hour, COUNT(*) AS total_orders
FROM orders o
GROUP BY hour
ORDER BY hour;

-- Top by busiest hours
SELECT EXTRACT(HOUR FROM o.time) AS hour,
       COUNT(*) AS total_orders
FROM orders o
GROUP BY hour
ORDER BY total_orders DESC
LIMIT 6;

-- Revenue by Pizza Category and Month
SELECT EXTRACT(MONTH FROM o.date) AS month,
       pt.category, SUM(od.quantity * p.price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY month, pt.category
ORDER BY month, revenue DESC;
