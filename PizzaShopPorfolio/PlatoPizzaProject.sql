-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM sales

-- Average Order Value
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Avg_Order_Value
FROM sales

--	Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM sales

--	Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM sales

-- Average Pizza per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Ordered
FROM sales

-- Chart Requirement
-- Hourly Tend for Total Orders
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY order_hour

-- Weekly Tend for Total Orders
SELECT EXTRACT(WEEK FROM order_date) AS week_number,
       EXTRACT(YEAR FROM order_date) AS order_year,
       COUNT(DISTINCT order_id) AS total_pizza_sold
FROM sales
GROUP BY EXTRACT(WEEK FROM order_date), EXTRACT(YEAR FROM order_date)
ORDER BY order_year, week_number;

-- Percentage of Sales by Category
-- By Year
SELECT pizza_category, SUM(total_price) AS Total_Sales,
       SUM(total_price) * 100 / (SELECT SUM(total_price) FROM sales) AS Percentage_Total_Sales
FROM sales
GROUP BY pizza_category

-- Month
SELECT pizza_category, SUM(total_price) AS Total_Sales,
       SUM(total_price) * 100 / (SELECT SUM(total_price) FROM sales WHERE EXTRACT(MONTH FROM order_date) = 1) AS Percentage_Total_Sales
FROM sales
WHERE EXTRACT(MONTH FROM order_date) = 1
GROUP BY pizza_category;

-- Percentage of Sales by Size
SELECT pizza_size, SUM(total_price) AS Total_Sales,
       SUM(total_price) * 100 / (SELECT SUM(total_price) FROM sales) AS PCT
FROM sales
GROUP BY pizza_size
ORDER BY PCT DESC

-- Total Pizza Sold by Category
SELECT pizza_category, SUM(total_price) AS Total_Sales
FROM sales
GROUP BY pizza_category;

-- Top 5 Best Sellers
--Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5
  
--Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5

-- Total Order
SELECT pizza_name, SUM(order_id) AS Total_Order
FROM sales
GROUP BY pizza_name
ORDER BY Total_Order DESC
LIMIT 5

-- Bottom 5 Sellers
-- Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5

-- Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity  
FROM sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5

-- Total Orders
SELECT pizza_name, SUM(order_id) AS Total_Order
FROM sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5



