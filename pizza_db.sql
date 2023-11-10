select * from pizza_sales;


-- 1) total revenue : The Sum of the total prize of all pizza order 
select Sum(total_price) as Total_Revenue from pizza_sales;

-- 2) Average Order value : The average amount spent per order, 
-- calculated by dividing the total revenue by the total number of orders.

select (sum(total_price)/ count(distinct order_id)) as Avg_Order_value
from pizza_sales;

-- 3) Total Pizza sold : The sum of the quantities of all pizzas sold

select sum(quantity) as Total_Pizza_Sold
from pizza_sales;

-- 4) Total Orders : The total number of order placed.

select count(distinct order_id) as Total_Order_Place
from pizza_sales;

-- 5) Average Pizzas Per Order : The average number of pizzas sold per order, 
-- calculated by dividing the total number of pizzas sold by the total number of orders.

select cast(cast(sum(quantity) as decimal (10,2)) /
cast (count(distinct order_id) as decimal (10,2)) as decimal (10,2)) as Average_Pizzas_per_order
from pizza_sales;

--  1) DAILY TREND FOR TOTAL ORDERS 
-- Create bar chart that displays the daily trend of total orders over specific time period.
--This chart will help us identify any patterns or fluctuations in order volumes on daily basis

select * from pizza_sales;

SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
GROUP BY DATENAME(DW, order_date);

-- 2) HOURLY TREND FOR TOTAL ORDERS
-- Create a line chart that illustrates the hourly trend of total orders throughout the day.
-- This chart will allow ua to identify peak hours or periods of high order activity.

SELECT DATENAME(MONTH, order_date) as Month_name , COUNT(DISTINCT order_id) as Monthly_Orders
from pizza_sales
group by DATENAME(MONTH, order_date)
ORDER BY Monthly_Orders DESC;

-- 3) PERCENTAGE OF SALES BY PIZZA CATEGORY
-- Create a pie chart that shows the distribution of sales across different pizza categories. 
--This chart will provide insights into the popularity of various pizza cateogories and their 
-- contribution to overall sales.

SELECT pizza_category,SUM(total_price) As total_sales ,SUM(total_price) * 100 / 
(select SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) as PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

-- 4) PERCENTAGE OF SALES BY PIZZA SIZE
-- Generate a pie chart that represents the percentage of sales attributed to different pizza sizes.
-- This chart will help us understand customer preferences for pizza sizes and their impact on sales
 
SELECT pizza_size, SUM(total_price) AS total_sales, CAST(SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, Order_Date) = 1 ) AS DECIMAL(10,2)) as pct
from pizza_sales
WHERE DATEPART(QUARTER, Order_Date) = 1
group by pizza_size
order by pct desc;

-- 5) TOTAL PIZZAS SOLD BY PIZZA CATEGORY
-- Create a funnel chart that presents the total number of pizzas sold for each pizza category.
-- This chart will allow us to compare the sales performance of different pizza categories.

SELECT pizza_size, SUM(total_price) AS total_sales, CAST(SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, Order_Date) = 1 ) AS DECIMAL(10,2)) as pct
from pizza_sales
WHERE DATEPART(QUARTER, Order_Date) = 1
group by pizza_size
order by pct desc;


-- 6) TOP 5 BEST SELLERS BY TOTAL PIZZAS SOLD
-- Create a bar chart highlighting the top 5 best-selling pizzas based on the total number of pizzas sold.
-- This chart will help us identity the most popular pizza options

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales 
GROUP BY pizza_NAME 
ORDER BY SUM(total_price) DESC;

-- 7) BOTTOM 5 WORST SELLERS BY TOTAL PIZZAS SOLD
-- Create a bar chart showcasing the bottom 5 worst-selling pizzas based on the total number of pizzas sold.
-- This chart will enable us to identify underperforming or less popular pizza options.

SELECT TOP 5 PIZZA_NAME, SUM(QUANTITY) AS TOTAL_QUANTITY
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(QUANTITY) ASC;










