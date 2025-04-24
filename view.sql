--monthly_sales_view

create or replace view monthly_sales_view as
select
	extract(year from o.order_date) as year,
	to_char(o.order_date,'fmmonth') as month,
	s.store_name,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_revenue
from sales.orders o
join sales.order_items oi
on o.order_id = oi.order_id
join sales.stores s
on o.store_id = s.store_id
group by year,month,s.store_name;

select * from monthly_sales_view;

-- top_customers_view

create or replace view top_customer_view as
select
	c.customer_id,
	concat(c.first_name,' ',c.last_name) as customer_name,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_revenue
from sales.customers c
join sales.orders o
on o.customer_id = c.customer_id
join sales.order_items oi
on oi.order_id = o.order_id
group by c.customer_id,customer_name;

select * from top_customer_view;

--staff_performance_view

create or replace view staff_performance_view as
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

select * from staff_performance_view;