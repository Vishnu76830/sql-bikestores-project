/*Q1. Identify the 3 highest revenue-generating products in 2018.
Show product name, total revenue, and total quantity sold.*/

select
	p.product_name,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_revenue,
	COUNT(*) AS total_sales
from sales.orders o
join sales.order_items oi
on o.order_id = oi.order_id
join production.products p
on oi.product_id = p.product_id
where o.order_date between '2018-01-01' and '2018-12-31'
group by p.product_name;

/*Q2. Which store has the highest average order value?
Include store name, total orders, total revenue, and average order value.*/

select 
	s.store_name,
	count(DISTINCT o.order_id) as orders,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_revenue,
	avg(oi.quantity*oi.list_price*(1-oi.discount)) as avg_order_value
from sales.stores s
join sales.orders o
on s.store_id = o.store_id
join sales.order_items oi
on o.order_id = oi.order_id
group by s.store_name;

/*Q3. List the top 5 customers based on the number of orders they placed.
Include customer name, email, city, and total orders.*/

select 
	concat(c.first_name,' ',c.last_name) as full_name,
	c.email,
	c.city,
	count(DISTINCT o.order_id) as orders
from sales.customers c
join sales.orders o
on c.customer_id = o.customer_id
group by full_name,c.email,c.city;

/*Q4. Calculate monthly revenue for each store in 2017.
Show: store name, year, month name, total revenue.*/

select
	s.store_name,
    extract(year from o.order_date) as year,
    TO_CHAR(o.order_date, 'Month') as month_name,
    sum(oi.quantity*oi.list_price-(1-oi.discount)) as total_revenue
from sales.orders o
join sales.order_items oi 
on o.order_id = oi.order_id
join production.products p 
on p.product_id = oi.product_id
join sales.stores s
on o.store_id = s.store_id
where o.order_date between '2017-01-01' and '2017-12-31'
group BY s.store_name,year, month_name
order by month_name,year ;

/*Q5. Show staff performance in terms of orders handled, total revenue generated, and delayed orders (if any).
Show staff name, number of orders, total revenue, and delayed orders count.*/

select 
	concat(s.first_name,' ',s.last_name) as stuff_name,
	count(distinct o.order_id) as total_order,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_revenue,
	count(case when o.shipped_date > o.required_date then 1 end) as delayed_orders
from sales.staffs s
join sales.orders o
on o.staff_id = s.staff_id
join sales.order_items oi
on o.order_id = oi.order_id
group by stuff_name;