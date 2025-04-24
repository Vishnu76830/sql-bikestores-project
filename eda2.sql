/* 1) Count rows in each table
This tells you how much data exists in each table. For example:
	How many customers are there?
	How many products?
	How many orders?

Why is it important:
	You can't analyze sales without knowing how many orders you have.
	You can't analyze staff performance without knowing how many staff exist.*/


select 'customers' as table_name, count(*) from sales.customers
union all
select 'orders', count(*) from sales.orders
union all
select 'order_items', count(*) from sales.order_items
union all
select 'staffs', count(*) from sales.staffs
union all
select 'stores', count(*) from sales.stores
union all
select 'products', count(*) from production.products
union all
select 'categories', count(*) from production.categories
union all
select 'brands', count(*) from production.brands
union all
select 'stocks', count(*) from production.stocks;


/* 2) Check for NULLs, uniqueness, duplicates
This tells you how much data exists in each table. For example:
	Any NULL values (missing data)
	Are IDs truly unique?
	How many emails are missing?

Why is it important:
	Missing or duplicate data = dirty data = false insights.*/
	
select 
  count(*) as total_rows,
  count(distinct customer_id) as unique_customers,
  count(*) - count(email) as null_emails
from sales.customers;

/* Check first and last order date
You find the earliest and latest dates of your order data.

Why is it important:
	Is this one-year data?
	Can I make monthly trends?
	Is seasonality even possible?*/
	
select
	min(order_date) as first_order,
	max(order_date) as last_order 
from sales.orders;
