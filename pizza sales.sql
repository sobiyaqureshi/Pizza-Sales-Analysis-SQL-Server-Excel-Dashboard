
USE pizzadb
SELECT * FROM pizza_sales

--# KPI Requirements # --

--Find total revenue -> sum of total price of all pizza orders
SELECT
CAST(SUM (total_price) AS decimal(10,2)) Total_revenue 
FROM pizza_sales


--Average order value -> Average amount spent per order i.e., Total revenue / total orders
SELECT 
CAST(SUM (total_price) / COUNT (DISTINCT order_id) AS decimal(10,2)) avg_order_value
FROM pizza_sales


--Total pizza sold -> the sum of quantities of all pizzas sold
SELECT 
SUM (quantity) AS Total_pizza_sold 
FROM pizza_sales 


--Total orders -> Total number of orders placed 
SELECT 
COUNT (DISTINCT order_id) total_orders
FROM pizza_sales


--Average pizzas per order -> total pizza sold / total orders
SELECT
CAST(CAST(SUM (quantity) AS decimal(10,2)) / 
CAST(COUNT (DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) avg_pizza_per_order
FROM pizza_sales


-- # Charts requirements # --

--Daily trend for total orders
SELECT 
DATENAME (DW, order_date) order_day,
COUNT (DISTINCT order_id) total_orders
FROM pizza_sales
GROUP BY DATENAME (DW, order_date)

-- Hourly trend for total orders
SELECT 
DATEPART (HOUR, order_time) order_hour,
COUNT (DISTINCT order_id) total_orders
FROM pizza_sales
GROUP BY DATEPART (HOUR, order_time)
ORDER BY DATEPART (HOUR, order_time) ASC

--Percentage of sales by pizza category
SELECT
pizza_category,
CAST (SUM (total_price) AS decimal(10,2)) total_sales,
CONCAT (CAST (SUM (total_price) * 100.0 / (SELECT SUM (total_price) FROM pizza_sales) AS decimal(10,2)), '%')  AS perc_of_sales
FROM pizza_sales
GROUP BY pizza_category

-- Percentage of sales by pizza size
SELECT
pizza_size,
CAST (SUM (total_price) AS decimal(10,2)) total_sales,
CONCAT (CAST (SUM (total_price) * 100.0 / (SELECT SUM (total_price) FROM pizza_sales) AS decimal(10,2)), '%')  AS perc_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY perc_of_sales

--Total pizzas sold by pizza category
SELECT
pizza_category,
SUM (quantity) AS pizza_sold
FROM pizza_sales
GROUP BY pizza_category

--Top 5 best sellers by total pizzas sold
SELECT TOP 5
pizza_name,
SUM (quantity) AS pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_sold DESC

--Bottom 5 worst sellers by total pizzas sold
SELECT TOP 5
pizza_name,
SUM (quantity) AS pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_sold 