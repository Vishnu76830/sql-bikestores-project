-- sales schema
-- stores table

CREATE TABLE sales.stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(10),
    zip_code VARCHAR(5)
);

-- staffs table

CREATE TABLE sales.staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(25),
    active BOOLEAN NOT NULL,
    store_id INT NOT NULL,
    manager_id INT,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id),
    FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id)
);

-- customers table

CREATE TABLE sales.customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone VARCHAR(25),
    email VARCHAR(255),
    street VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(25),
    zip_code VARCHAR(5)
);

-- orders table

CREATE TABLE sales.orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_status SMALLINT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id),
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id),
    FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id)
);

-- order_items table

CREATE TABLE sales.order_items (
    order_id INT,
    item_id INT,
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(4,2),
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES sales.orders (order_id),
    FOREIGN KEY (product_id) REFERENCES production.products (product_id)
);

-- Production Schema
-- brands table

CREATE TABLE production.brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(255)
);

-- categories

CREATE TABLE production.categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

-- products

CREATE TABLE production.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    brand_id INT,
    category_id INT,
    model_year SMALLINT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id),
    FOREIGN KEY (category_id) REFERENCES production.categories (category_id)
);

-- stock table

CREATE TABLE production.stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id),
    FOREIGN KEY (product_id) REFERENCES production.products (product_id)
);