--create table
create table retail_sales(
	transactions_id	int primary key,
	sale_date	date,
	sale_time	time,
	customer_id	int,
	gender	varchar(15),
	age	int,
	category varchar(25),	
	quantiy	int,
	price_per_unit float,	
	cogs	float,
	total_sales float

);

select * from retail_sales limit 10;

--no of  records
select count(*) from retail_sales;
--
select * from retail_sales 
where transactions_id is null;

select * from retail_sales 
where sale_date is null;

select * from retail_sales 
where sale_time is null;
-- checking null values in all columns
select * from retail_sales
where
	 transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or 
	 total_sales is null;
	 
-- deleting null values

delete from retail_sales
where
	 transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or 
	 total_sales is null;
	 
--Data Explolration
-- how many sales we have?
select count(*) as total_sale from retail_sales;

--how many customers we have?
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category as total_sale from retail_sales;

--Data Analysis & Business problems 

--Q.1 Write a sql query to retreive all columns for sales made on '2022-11-05'

select * from retail_sales 
where 
	sale_date='2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity said to more than 4 in the month of nov-2022

select * 
from retail_sales 
where  
	  category='clothing' 
	  and 
	  to_char(sale_date,'YYYY-MM')='2022-11'
	  and
	  quantiy>=4;

--Q.3 Write a SQL query to calculate the total sales for each category.

select category,count(*) 
	  as total_sales,
	  sum(total_sales) as net_sales
from retail_sales
group by category;

--Q.4 write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
 category,round(avg(age),2) as average_age
 from retail_sales
 where category='Beauty'
group by category;

--Q.5 Write a SQL query to find all the transactions where the total_sales is greater than 1000.

select *
from retail_sales
where
	total_sales>1000;
--Q.6 Write a SQL query to find total no of transactions (transactions_id) made by each gender in each category.

select category,gender,count(*) as total_trans
from retail_sales
group by category,gender
order by 1;

--Q.7 Calculate the average sale for each month.Find out the best selling month in each year.
select 
	year,
	month,
	avg_sales
from(
	select 
	extract(year from sale_date) as year,
	extract (month from sale_date) as month,
	avg(total_sales) as avg_sales,
	rank() over(partition by extract(year from sale_date) order by avg(total_sales) desc) as rank
	from retail_sales
	group by 1,2
) as t1
where rank=1;

--Q.8 Find the top 5 customers based on highest total sales.


select 
	customer_id,
	sum(total_sales) as total_sales
	from retail_sales
group by 1
order by 2 desc
limit 5;

--Q.9 Find the number of unique customers who have purchased items from each category.
select 
	category,
	count(distinct customer_id)
from retail_sales
group by category

--Q.10 Writa SQL Query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with t1 as 
(
select *,
case 
	when extract(hour from sale_time)<12 then 'Morning'
	when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
end as shift
from retail_sales
)
select 
shift,
count(*) as total_orders 
from t1 
group by shift;

--
