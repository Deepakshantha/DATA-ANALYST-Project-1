
-- using [Pizzadetails] database--
  use Pizzadetails;

-- view tables--
 select * from pizza_sales;
 
 -- 1. sum of total price
 select sum(total_price) as total_revenue from pizza_sales;
 
 -- 2. Total orders & Total orders / Total revenue--
 select count(distinct order_id )  as totalordr_id from pizza_sales;
 select  sum(total_price)  / count(distinct order_id ) as Average_orders FROM pizza_sales;
 
 -- 3. Total quantity--
 select sum(quantity) as Total_quantity from pizza_sales;
 
 -- 4. Total quantity / Total orders--
 select cast(cast(sum(quantity)as decimal (10,2)) / cast(count(distinct order_id)as decimal (10,2))as decimal (10,2)) as average_pizza_per_order from pizza_sales;

-- 5. Average order in daily bases--
SELECT 
    DATENAME(DW , ORDER_DATE) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
DATENAME(DW , ORDER_DATE)

-- 6. Average order in month bases--
select 
     datename(month , ORDER_DATE) as order_month , COUNT(DISTINCT order_id) AS total_orders from   pizza_sales
	 group by datename(month , ORDER_DATE)
	 order by total_orders desc

-- 7. percentage of pizza category--
     select pizza_category ,cast(sum(total_price) as decimal (10,2)) as total_sales , cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales )as decimal (10,2)) as percentage from pizza_sales
	 group by pizza_category

-- 8. percentage of pizza category--
     select pizza_category , cast(sum(total_price) as decimal (10,2)) as total_sales , cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales where month(order_date) = 3 ) as decimal (10,2))  as percentage from pizza_sales
	 where month(order_date) = 3
	 group by pizza_category

-- 9. percentage of pizza size in month bases--
      select pizza_size , cast(sum(total_price) as decimal (10,2)) as total_sales , cast(sum(total_price) * 100 / (select sum(total_price)   from pizza_sales where month(order_date) = 4 )as decimal (10,2)) as percentage from pizza_sales
	   where month(order_date) = 4
	 group by pizza_size
	 order by percentage desc

-- 10. TOP 5 best selling pizzas--
      select top 5 pizza_name , sum(total_price) as total_revenue from pizza_sales              -- TOP 5 best selling pizzas per total_price--
	  group by pizza_name
	  order by  total_revenue desc
	   
	      
		  select top 5 pizza_name , sum(quantity) as total_quantity from pizza_sales            -- TOP 5 best selling pizzas per quantity--
	  group by pizza_name
	  order by total_quantity  desc

	  select top 5 pizza_name , count(DISTINCT order_id) as total_orders from pizza_sales         -- TOP 5 best selling pizzas per order_id--
	  group by pizza_name
	  order by total_orders  desc

