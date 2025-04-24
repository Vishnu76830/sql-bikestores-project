/*Monthly Sales Trend
What to Find:
	Total sales per month (2016–2018).
	Use sales.orders + sales.order_items + production.products with join
Why it needed:
	This insight helps the business identify seasonal trends.
	detect peak or slow months.
	plan marketing campaigns or inventory accordingly.*/

SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    TO_CHAR(o.order_date, 'Month') AS month_name,
    COUNT(*) AS total_sales
FROM sales.orders o
JOIN sales.order_items oi ON o.order_id = oi.order_id
JOIN production.products p ON p.product_id = oi.product_id
GROUP BY year, month_name
ORDER BY month_name,year ;

/*What to Find:
	Top 10 products by quantity sold.
	Use sales.order_items + production.products
Why it needed:
	This helps the business identify the most popular products.
	These products can be prioritized for stock refills, featured listings, or bundled promotions.*/

select 
	p.product_name,
	sum(oi.quantity) as total_quantity
from sales.order_items oi
join production.products p
on oi.product_id = p.product_id
group by p.product_name
order by total_quantity desc
limit 10;

/*Sales by Category
What to find:
	Total revenue grouped by product category.
	Use products, categories, order_items

Why it needed:
	Understand which product types bring in the most money.
	Crucial for category-wise inventory planning and targeted advertising.*/

select 
	c.category_name,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as revenue
from sales.order_items oi
join production.products p
on p.product_id = oi.product_id
join production.categories c
on p.category_id = c.category_id
group by c.category_name
order by revenue desc;

/*Top Performing Staff
What to Find:
	Which staff processed the most orders / highest revenue.

Why it needed:
	Performance review, incentive, aur training ke liye.*/

select 
	concat(s.first_name,' ',s.last_name) as staff_name,
	count(DISTINCT o.order_id) as most_orders,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_revenue
from sales.staffs s
join sales.orders o
on s.staff_id = o.staff_id
join sales.order_items oi
on o.order_id = oi.order_id
group by staff_name
order by total_revenue desc;

/*Top Stores by Sales
What:
	List stores with highest revenue and order count.

Why:
	Tells management which store is performing best — important for expansion planning or internal comparison.*/

select 
	s.store_name,
	sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_revenue,
	count(DISTINCT o.order_id) as orders
from sales.stores s
join sales.orders o
on o.store_id = s.store_id
join sales.order_items oi
on oi.order_id = o.order_id
group by s.store_name;

/*Customers by Spend (Segmentation)
What:
	Group customers by their total spend (High, Medium, Low).

Why:
	Helpful for personalized marketing.
	Target high spenders for loyalty offers and low spenders for re-engagement.*/

select 
	concat(first_name,' ',last_name) as full_name,
	(sum(oi.quantity*oi.list_price*(1-oi.discount)),2) as spend_total,
	case
		when sum(oi.quantity*oi.list_price-(1-oi.discount)) >= 10000 then 'high'
		when sum(oi.quantity*oi.list_price-(1-oi.discount)) between 4000 and 9999 then 'medium'
		else 'low'
	end as spend_category
from sales.customers c
join sales.orders o
on c.customer_id = o.customer_id
join sales.order_items oi
on o.order_id = oi.order_id
group by full_name
order by spend_total desc;

/*Delayed Orders
What:
	Find orders where the shipment date was later than required date.

Why:
	Late deliveries impact customer satisfaction.
	Helps in identifying fulfillment delays and operational bottlenecks.*/

select 
	s.store_name,
	o.order_id,
	o.customer_id,
	o.order_status,
	o.order_date,
	required_date,
	shipped_date
from sales.orders o
join sales.stores s
on s.store_id = o.store_id
where o.shipped_date > o.required_date;
