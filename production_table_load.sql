--brands
create table production.brands (
    brand_id INT primary key,
    brand_name VARCHAR(255));

--categories
create table production.categories (
    category_id SERIAL primary key,
    category_name VARCHAR(255) not null);

--products
create table production.products (
    product_id SERIAL primary key,
    product_name VARCHAR(255) not null,
    brand_id INT references production.brands(brand_id),
    category_id INT references production.categories(category_id),
    model_year SMALLINT not null,
    list_price DECIMAL(10,2) not null); 

--stocks
create table production.stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    primary key (store_id, product_id),
    foreign key (store_id) references sales.stores (store_id),
    foreign key (product_id) references production.products (product_id));