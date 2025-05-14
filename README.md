# DATA ANALYST (Project 1)

## Pizza Sales Analysis

### Description (Comprehensive Data Analysis Project Using Excel, SQL Server, and Power BI)
* In my recent data analysis project, I utilized Excel to organize and clean the raw data.
* I then imported this data into SQL Server Management Studio to perform complex queries and data manipulation.
* Finally, I used Power BI to create interactive dashboards and visualizations, providing insightful reports on the data trends and patterns. This comprehensive approach allowed me to effectively analyze and present the data, making it easier to derive actionable insights.
* This repository contains SQL queries for analyzing pizza sales data from the Pizzadetails database. The queries cover various aspects of sales, including total revenue, order counts, average orders, quantities, and percentages of different categories and sizes.

### Database
The analysis is performed on the Pizzadetails database, specifically the pizza_sales table.

### Queries
### 1. View Tables

USE Pizzadetails;
SELECT * FROM pizza_sales;

### 2. Sum of Total Price

SELECT SUM(total_price) AS total_revenue FROM pizza_sales;

### 3. Total Orders & Average Orders per Total Revenue

SELECT COUNT(DISTINCT order_id) AS totalordr_id FROM pizza_sales;
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_orders FROM pizza_sales;

### 4. Total Quantity

SELECT SUM(quantity) AS Total_quantity FROM pizza_sales;

### 5. Average Quantity per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS average_pizza_per_order FROM pizza_sales;

### 6. Average Orders on Daily Basis

SELECT DATENAME(DW, ORDER_DATE) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, ORDER_DATE);

### 7. Average Orders on Monthly Basis

SELECT DATENAME(MONTH, ORDER_DATE) AS order_month, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, ORDER_DATE)
ORDER BY total_orders DESC;

### 8. Percentage of Pizza Category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS percentage
FROM pizza_sales
GROUP BY pizza_category;

### 9. Percentage of Pizza Category for March

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 3) AS DECIMAL(10,2)) AS percentage
FROM pizza_sales
WHERE MONTH(order_date) = 3
GROUP BY pizza_category;

### 10. Percentage of Pizza Size for April

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 4) AS DECIMAL(10,2)) AS percentage
FROM pizza_sales
WHERE MONTH(order_date) = 4
GROUP BY pizza_size
ORDER BY percentage DESC;

### 11. Top 5 Best Selling Pizzas By Total Price

SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;

### By Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC;

### By Order ID

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC;


