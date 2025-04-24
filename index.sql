/*Index on product_id in order_items
Used in joins between order_items and products, especially in product-based insights.*/

create index
idx_order_items_product_id 
on sales.order_items(product_id);


/*Index on order_date
Because you filter/group on this column in almost every insight (monthly/yearly revenue).*/

create index
idx_orders_order_date 
on sales.orders(order_date);


/*Index on customer_id in orders
Used in joins and when checking customer orders, segments, and loyalty.*/

create index
idx_orders_customer_id 
on sales.orders(customer_id);


--Index Queries

--This query checks whether the database is using the index on the order_date column while filtering orders.
explain analyze
select * 
from sales.orders 
where order_date between '2018-01-01' and '2018-12-31';


--This query shows all the indexes created inside the sales schema.
select
    tablename, 
    indexname, 
    indexdef
from pg_indexes
where schemaname = 'sales';

